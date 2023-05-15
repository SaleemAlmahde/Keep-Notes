import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'my_db.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get dec => text().nullable()();
  // BlobColumn get list => blob().nullable()();
}

@DriftAccessor(tables: [Notes])
class NotesDao extends DatabaseAccessor<MyDB> with _$NotesDaoMixin {
  MyDB db;
  NotesDao(this.db) : super(db);
  Stream<List<Note>> watchAll() => select(notes).watch();
  Future<List<Note>> getAll() => select(notes).get();
  Future<Note> getById(int id) =>
      (select(notes)..where((row) => row.id.equals(id))).getSingle();
  Future<int> insertNote(Note note) => into(notes).insert(
        NotesCompanion(
          id: const Value.absent(),
          title: Value<String>.ofNullable(note.title),
          dec: Value<String>.ofNullable(note.dec),
          // list: Value(note.list),
        ),
      );
  Future<bool> updateNote(Note note) => update(notes).replace(note);
  Future<int> deleteNoteById(int id) =>
      (delete(notes)..where((row) => row.id.equals(id))).go();
}

@DriftDatabase(tables: [Notes], daos: [NotesDao])
class MyDB extends _$MyDB {
  MyDB() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAllTables();
        },
        onUpgrade: (m, from, to) async {
          if (from == 1) {
            await m.createTable(notes);
          }
        },
      );
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
