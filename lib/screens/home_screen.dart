import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeit/main.dart';
import 'package:codeit/methods/questionUpload.dart';
import 'package:codeit/screens/first_screen.dart';
import 'package:codeit/utils/colors.dart';
import 'package:codeit/utils/constants.dart';
import 'package:codeit/widgets/home_screen_questions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
      var permissionStatus = await Permission.storage.status;
      if (permissionStatus != PermissionStatus.granted) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        setState(() {
          permissionStatus = permissionStatus;
        });
      }
    };
  }

  final Stream<QuerySnapshot> _questionsStream = firestore
      .collection('questions')
      .orderBy('dateTime', descending: true)
      .snapshots();
  TextEditingController questionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Widget> imagesAdded = [];
  List<String> imagesLinks = [];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                                uploadQuestion(questionController.text,
                                    descriptionController.text, imagesLinks);
                                questionController.text = "";
                                imagesAdded = [];
                                imagesLinks = [];
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _questionsStream,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: snapshot.data!.docs.map(
                  (DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return homeScreenQuestions(
                        data["question"],
                        data["desc"],
                        data["author_name"],
                        data["author_picture"],
                        data["img_urls"],
                        document.id,
                        data["answers"],
                        context);
                  },
                ).toList(),
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
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

