import 'dart:io';

import 'package:codeit/methods/questionUpload.dart';
import 'package:codeit/screens/home_screen.dart';
import 'package:codeit/utils/colors.dart';
import 'package:codeit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RealHomeScreen extends StatefulWidget {
  const RealHomeScreen({Key? key}) : super(key: key);

  @override
  State<RealHomeScreen> createState() => _RealHomeScreenState();
}

TextEditingController questionController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
List<Widget> imagesAdded = [];
List<String> imagesLinks = [];
int techOrNot = 0;
Widget x = const HomeScreen(
  screenType: 'questions',
);

class _RealHomeScreenState extends State<RealHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.all(15),
        padding: EdgeInsets.zero,
        child: CircleAvatar(
            radius: 30,
            backgroundColor: loginButtonColor,
            child: IconButton(
              iconSize: 40,
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.black,
                  context: context,
                  builder: (contextt) {
                    return StatefulBuilder(
                        builder: (contextt, StateSetter setStatee) {
                      return SafeArea(
                        child: Column(
                          children: [
                            TextField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Question",
                                icon: Icon(
                                  Icons.question_answer_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              autofocus: true,
                              maxLength: 40,
                              controller: questionController,
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            TextField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: "Description",
                                  icon: Icon(
                                    Icons.question_answer,
                                    color: Colors.white,
                                  )),
                              controller: descriptionController,
                              onSubmitted: (str) {
                                FocusScope.of(context).unfocus();
                              },
                            ),
                            imagesAdded.isNotEmpty
                                ? Expanded(
                                    child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: imagesAdded),
                                  )
                                : Container(),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 10),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  onPressed: () {
                                    getImages().then((value) => () {
                                          setStatee(() {});
                                        });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.image),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Add images")
                                    ],
                                  )),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(contextt);
                                uploadQuestion(
                                    questionController.text,
                                    descriptionController.text,
                                    imagesLinks,
                                    techOrNot);
                                questionController.text = "";
                                imagesAdded = [];
                                imagesLinks = [];
                                descriptionController.text = "";
                                Navigator.popAndPushNamed(context, 'home');
                              },
                              child: const Text("Submit"),
                            )
                          ],
                        ),
                      );
                    });
                  },
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showMenu(
                color: Colors.black,
                context: context,
                position: RelativeRect.fromLTRB(width * 0.95, 0, 0, 0),
                items: [
                  PopupMenuItem(
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      auth.signOut();
                      Navigator.popAndPushNamed(context, 'first');
                    },
                  )
                ],
              );
            },
          )
        ],
        backgroundColor: bgColor,
        leading: Image.asset(
          "assets/images/codeitlogo.png",
          height: 40,
        ),
        title: const Text(
          "Home",
          style: TextStyle(
              fontFamily: 'Inter', fontSize: 25, fontWeight: FontWeight.w700),
        ),
        titleSpacing: 15,
      ),
      body: Scaffold(
        backgroundColor: const Color(0xFF303030),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              techOrNot = 0;
                              x = const HomeScreen(
                                screenType: 'questions',
                              );
                            });
                          },
                          style: techOrNot == 0
                              ? ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF264781))
                              : ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2F2F2F)),
                          child: const Text("Tech"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              techOrNot = 1;
                              x = const HomeScreen(
                                screenType: 'nonTechQuestions',
                              );
                            });
                          },
                          style: techOrNot == 1
                              ? ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF264781))
                              : ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2F2F2F)),
                          child: const Text("Non-Tech"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              techOrNot = 3;
                              x = const HomeScreen(
                                screenType: 'nonVIT',
                              );
                            });
                          },
                          style: techOrNot == 3
                              ? ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF264781))
                              : ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2F2F2F)),
                          child: const Text("Non-VIT"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                  ],
                ),
                x
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getImages() async {
    List<XFile> images = await ImagePicker().pickMultiImage();
    for (XFile image in images) {
      imagesAdded.add(
        Image.file(
          File(image.path),
          height: 40,
        ),
      );
      var reference = storage.ref().child(
          "images/${auth.currentUser!.uid}/${DateTime.now().toString()}");
      var uploadTask = reference.putFile(File(image.path));
      String location = await (await uploadTask).ref.getDownloadURL();
      imagesLinks.add(location);
    }
  }

  void buttonPressed(String text) {
    setState(() {
      tagSelected = text;
    });
  }
}
