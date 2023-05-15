import 'package:keep_notes/bloc/cubits/app_cubit.dart';
import 'package:keep_notes/bloc/states/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_notes/pages/checkBox_page.dart';
import 'package:keep_notes/pages/home_page_v2.dart';
import 'package:keep_notes/pages/note_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: TextFormField(
                  controller: appCubit.searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.crop_square_outlined),
                          color: Colors.grey,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage2(),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear),
                          color: Colors.grey,
                          onPressed: () {
                            appCubit.clearSearch();
                          },
                        ),
                      ],
                    ),
                    hintText: 'Search your notes',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.grey[900],
            // actions: [
            //   IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            // ],
          ),
          backgroundColor: Colors.grey[900],
          body: ListView.builder(
            itemCount: appCubit.notesList.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(5),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                title: Text(
                  appCubit.notesList[index].title ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  appCubit.notesList[index].dec ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  appCubit.fillNotes(appCubit.notesList[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NoteDetails(),
                    ),
                  );
                },
                trailing: IconButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                            "Are you sure you want to delete this Note?"),
                        content: const Text("this operation cannot be undone!"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No")),
                          TextButton(
                            onPressed: () async {
                              await appCubit
                                  .deleteNote(appCubit.notesList[index].id);
                              if (!context.mounted) return;
                              Navigator.pop(context);
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // bottomNavigationBar: BottomNavigationBar(

          //   backgroundColor: Colors.grey[850],
          //   elevation: 1.6,
          //   selectedItemColor: Colors.grey[200],
          //   type: BottomNavigationBarType.fixed,
          //   currentIndex: appCubit.selectedIndex,
          //   showSelectedLabels: false,
          //   showUnselectedLabels: false,
          //   onTap: (index) {
          //     if (index == 0) {
          //       appCubit.clearNotes();
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const CheckBoxPage(),
          //         ),
          //       );
          //     } else if (index == 1) {
          //       appCubit.clearNotes();
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const NoteDetails(),
          //         ),
          //       );
          //     } else if (index == 2) {
          //       appCubit.clearNotes();
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const NoteDetails(),
          //         ),
          //       );
          //     } else if (index == 3) {
          //       appCubit.clearNotes();
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const NoteDetails(),
          //         ),
          //       );
          //     }
          //     appCubit.navigatebottomiBar(index);
          //   },
          //   items: [
          //     BottomNavigationBarItem(
          //       icon: Icon(
          //         Icons.check_box_outlined,
          //         color: Colors.grey[200],
          //       ),
          //       tooltip: "New list",
          //       label: "",
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(
          //         Icons.draw_outlined,
          //         color: Colors.grey[200],
          //       ),
          //       tooltip: "New drawing note",
          //       label: "",
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(
          //         Icons.mic_none_rounded,
          //         color: Colors.grey[200],
          //       ),
          //       tooltip: "New audio note",
          //       label: "",
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(
          //         Icons.photo_outlined,
          //         color: Colors.grey[200],
          //       ),
          //       tooltip: "New photo note",
          //       label: "",
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(
          //         Icons.add,
          //         color: Colors.grey[850],
          //       ),
          //       label: "",
          //     ),
          //   ],
          // ),
          floatingActionButton: FloatingActionButton(
            elevation: 2,
            backgroundColor: Colors.grey[850],
            onPressed: () {
              appCubit.clearNotes();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoteDetails(),
                ),
              );
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BottomAppBar(
            //elevation: 0.2,
            notchMargin: 7,
            clipBehavior: Clip.antiAlias,
            color: Colors.grey[850],
            shape: const AutomaticNotchedShape(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    onPressed: () {
                      appCubit.clearNotes();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckBoxPage(),
                          ));
                    },
                    icon: Icon(
                      Icons.check_box_outlined,
                      color: Colors.grey[200],
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    onPressed: () {
                      appCubit.clearNotes();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckBoxPage(),
                          ));
                    },
                    icon: Icon(
                      Icons.draw_outlined,
                      color: Colors.grey[200],
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    onPressed: () {
                      appCubit.clearNotes();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckBoxPage(),
                          ));
                    },
                    icon: Icon(
                      Icons.mic_none_rounded,
                      color: Colors.grey[200],
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    onPressed: () {
                      appCubit.clearNotes();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckBoxPage(),
                          ));
                    },
                    icon: Icon(
                      Icons.photo_outlined,
                      color: Colors.grey[200],
                    ),
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
