import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_notes/bloc/cubits/app_cubit.dart';
import 'package:keep_notes/dataBase/my_db.dart';
import 'package:keep_notes/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  MyDB db = MyDB();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AppCubit(db)..watchNotes()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
