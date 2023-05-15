import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_notes/bloc/cubits/app_cubit.dart';
import 'package:keep_notes/bloc/states/app_state.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.appCubit,
    this.onTap,
    required this.index,
  });
  final AppCubit appCubit;
  final void Function()? onTap;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[900],
          body: Card(
            color: Colors.grey[900],
            shadowColor: Colors.white,
            child: InkWell(
              onTap: onTap,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appCubit.notesList[index].title??"",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(appCubit.notesList[index].dec??"",
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
