import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeit/utils/colors.dart';
import 'package:codeit/utils/constants.dart';
import 'package:codeit/widgets/answer_component.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class AnswerScreen extends StatefulWidget {
  String id;
  String type;
  Widget images;
  AnswerScreen({
    Key? key,
    required this.images,
    required this.id,
    required this.type,
  }) : super(key: key);

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

TextEditingController textarea = TextEditingController();

class _AnswerScreenState extends State<AnswerScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: Image.asset(
          "assets/images/codeitlogo.png",
          height: 40,
        ),
        title: const Text(
          "Answer",
          style: TextStyle(
              fontFamily: 'Inter', fontSize: 25, fontWeight: FontWeight.w700),
        ),
        titleSpacing: 15,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: getQues(widget.id, widget.type),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Title: ",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 30),
                                ),
                                SizedBox(
                                    width: width * 0.8,
                                    child: Text(
                                      snapshot.data!["question"],
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.0125,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Desc: ",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                                SizedBox(
                                    width: width * 0.8,
                                    child: Text(snapshot.data!["desc"],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15))),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            widget.images,
                            SizedBox(
                              height: height * 0.0125,
                            ),
                            SizedBox(
                              height: height * 0.0125,
                            ),
                            Text(
                              snapshot.data!["answers"].isEmpty
                                  ? "No answers available! "
                                  : "Answers: ",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 15),
                            ),
                            SizedBox(
                              height: height * 0.0125,
                            ),
                            snapshot.data!["answers"].isEmpty
                                ? Column()
                                : Container(
                                    child: ListView.builder(
                                      itemCount:
                                          snapshot.data!["answers"].length,
                                      itemBuilder: (context, i) {
                                        return AnswerComponent(
                                            picUrl: snapshot.data!["answers"][i]
                                                .substring(0, 86),
                                            author: snapshot.data!["answers"][i]
                                                .substring(86, 96),
                                            ansText: snapshot.data!["answers"]
                                                    [i]
                                                .substring(96));
                                      },
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                    ),
                                  )
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  }
                }),
            Container(
              margin: const EdgeInsets.all(15),
              child: auth.currentUser!.email!.contains("@vitbhopal.ac.in")
                  ? Row(
                      children: [
                        Expanded(
                            child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            hintText: "Add an answer!",
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                          controller: textarea,
                        )),
                        ElevatedButton(
                            onPressed: () {
                              if (textarea.text != "") {
                                firestore
                                    .collection(widget.type)
                                    .doc(widget.id)
                                    .update({
                                  "answers": FieldValue.arrayUnion([
                                    "${auth.currentUser!.photoURL}${ReCase(auth.currentUser!.displayName!.substring(auth.currentUser!.displayName!.length - 10, auth.currentUser!.displayName!.length)).originalText.toUpperCase()}${textarea.text}"
                                  ]),
                                });
                                setState(() {});
                                textarea.text = "";
                              } else {
                                SnackBar x =
                                    SnackBar(content: Text("Enter answer!"));
                                ScaffoldMessenger.of(context).showSnackBar(x);
                              }
                            },
                            child: const Text("Post"))
                      ],
                    )
                  : Row(),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>> getQues(
    String docId, String collectionType) {
  var data = firestore.collection(collectionType).doc(docId).get();
  return data;
}
