import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keep_notes/bloc/states/app_state.dart';
import 'package:keep_notes/dataBase/my_db.dart';

class AppCubit extends Cubit<AppStates> {
  MyDB db;
  static AppCubit get(context) => BlocProvider.of(context);
  AppCubit(this.db) : super(AppInitialState());

  List<Note> notesList = [];
  List<TextEditingController> listController = [TextEditingController()];
  List<bool> listCheckBox = [false];
  int? selectedId;
  int is2FieldNull = 0;
  int selectedIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController decController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  void clearNotes() {
    titleController.text = "";
    decController.text = "";
    selectedId = null;
    emit(AppRefreshUIState());
  }

  void fillNotes(Note note) {
    titleController.text = note.title??"";
    decController.text = note.dec??"";
    emit(AppRefreshUIState());
  }

  void watchNotes() {
    db.notesDao.watchAll().listen((notes) {
      notesList.clear();
      for (var element in notes) {
        notesList.add(element);
      }
      emit(AppRefreshUIState());
    });
  }

  Future<void> insertNote() async {
    var insertedId = await db.notesDao.insertNote(
      Note(
        id: 0,
        dec: decController.text.trim(),
        title: titleController.text.trim(),
      ),
    );
    print(insertedId);
  }

  Future<void> updateNote() async {
    var res = await db.notesDao.updateNote(
      Note(
        id: 0,
        dec: decController.text.trim(),
        title: titleController.text.trim(),
      ),
    );
    print(res);
  }

  Future<void> saveNote() async {
    if (selectedId == null) {
      await insertNote();
    } else {
      await updateNote();
    }
  }

  Future<void> deleteNote(int id) async {
    var res = await db.notesDao.deleteNoteById(id);
    emit(AppRefreshUIState());
    print(res);
  }

  void clearSearch() {
    searchController.text = "";
    emit(AppRefreshUIState());
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: 'This is toast notification',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black);
  }

  void navigatebottomiBar(int index) {
    selectedIndex = index;
    emit(AppRefreshUIState());
  }

  void checkBoxChangedEvent(int index, newValue) {
    listCheckBox[index] = newValue;
    // bool chekBox = listCheckBox[index];
    // listCheckBox.sort(
    // //   (a, b) => (a == b ? 0 : (a ? 1 : -1)),
    // );
    emit(AppRefreshUIState());
  }

  void addController() {
    listController.add(TextEditingController());
    listCheckBox.add(false);
    // print(listController.length);
    // print(listCheckBox.length);
    emit(AppRefreshUIState());
  }

  void deleteController(int index) {
    listController[index].clear();
    listController[index].dispose();
    listController.removeAt(index);

    // print(index);

    emit(AppRefreshUIState());
  }
}
