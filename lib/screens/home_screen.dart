import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeit/methods/questionUpload.dart';
import 'package:codeit/utils/colors.dart';
import 'package:codeit/utils/constants.dart';
import 'package:codeit/widgets/home_screen_questions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stretchy_header/stretchy_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    () async {
      var _permissionStatus = await Permission.storage.status;

      if (_permissionStatus != PermissionStatus.granted) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        setState(() {
          _permissionStatus = permissionStatus;
        });
      }
    };
  }
  final Stream<QuerySnapshot> _questionsStream = firestore.collection('questions').snapshots();
  TextEditingController questionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Widget> imagesAdded = [];
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
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
                                icon: Icon(Icons.question_answer_outlined, color: Colors.white,),
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
                                  icon: Icon(Icons.question_answer, color: Colors.white,)),
                              maxLength: 40,
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
                              margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  onPressed: ()  {
                                    getImages().then((value) => (){
                                      setStatee(() {

                                      });
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.image),
                                      SizedBox(width: 10,),
                                      Text("Add images")
                                    ],
                                  )),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(contextt);
                                uploadQuestion(questionController.text,
                                    descriptionController.text);
                                questionController.text = "";
                                imagesAdded = [];
                                descriptionController.text = "";
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
      body: StretchyHeader.singleChild(
        headerData: HeaderData(
            header: AppBar(
              backgroundColor: bgColor,
              leading: Image.asset(
                "assets/images/codeitlogo.png",
                height: 40,
              ),
              title: const Text(
                "Home",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
              titleSpacing: 0,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            headerHeight: 100),
        child: StreamBuilder<QuerySnapshot>(
          stream: _questionsStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }
            return Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return homeScreenQuestions(data["question"], data["description"], data["author_name"], data["author_picture"]);
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
  Future<void> getImages() async {
    List<XFile> images = await ImagePicker().pickMultiImage();
    setState(() {
      for (XFile image in images) {
        imagesAdded.add(
          Image.file(
            File(image.path),
            height: 40,
          ),
        );
      }
    });
  }
  void buttonPressed(String text) {
    setState(() {
      tagSelected = text;
    });
  }
}
// Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     buttonPressed("AIML");
//                   },
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: loginButtonColor,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15))),
//                   child: const Text("AIML"),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: loginButtonColor,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15))),
//                   onPressed: () {
//                     buttonPressed("C++");
//                   },
//                   child: const Text("C++"),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: loginButtonColor,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15))),
//                   onPressed: () {
//                     buttonPressed("Python");
//                   },
//                   child: const Text("Python"),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: loginButtonColor,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15))),
//                   onPressed: () {
//                     buttonPressed("Dart");
//                   },
//                   child: const Text("Dart"),
//                 ),
//               ],
//             ),
//             homeScreenQuestions("Yo")
//           ],
//         ),