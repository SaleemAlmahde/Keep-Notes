import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_notes/bloc/cubits/app_cubit.dart';
import 'package:keep_notes/bloc/states/app_state.dart';

class CheckBoxPage extends StatefulWidget {
  const CheckBoxPage({super.key});

  @override
  State<CheckBoxPage> createState() => _CheckBoxPageState();
}

class _CheckBoxPageState extends State<CheckBoxPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.save_outlined,
                  color: Colors.grey[300],
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: appCubit.titleController,
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                    decoration: const InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    // validator: (currentText) {
                    //   if (currentText == "") {
                    //     Fluttertoast.showToast(msg: "msg");
                    //   }
                    // },
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  itemCount: appCubit.listController.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                controller: appCubit.listController[index],
                                autofocus: false,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Checkbox(
                                      focusColor: Colors.blue,
                                      checkColor: const Color.fromARGB(
                                          255, 19, 27, 117),
                                      activeColor: Colors.grey,
                                      side: const BorderSide(
                                          color: Colors.grey, width: 2),
                                      value: appCubit.listCheckBox[index],
                                      onChanged: (value) {
                                        // print(index);

                                        appCubit.checkBoxChangedEvent(
                                            index, value);
                                      }),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          index != 0
                              ? GestureDetector(
                                  onTap: () {
                                    appCubit.deleteController(index);
                                  },
                                  child: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                    size: 35,
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: appCubit.addController,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          // decoration: BoxDecoration(
                          //     color: const Color(0xFF444C60),
                          //     borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(bottom: 3),
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 30,
                                  ),
                                  // style:
                                  // GoogleFonts.nunito(color: const Color(0xFFF8F8FF))
                                ),
                              ),
                              Text(
                                " List item",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  // width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      appCubit.saveNote();
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                    child: const Text("Save"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
