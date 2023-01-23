import 'package:codeit/utils/colors.dart';
import 'package:flutter/material.dart';

class AnswerScreen extends StatefulWidget {
  String title;
  String desc;
  Widget images;
  String id;
  List<dynamic> answers;
  AnswerScreen(
      {Key? key,
      required this.title,
      required this.images,
      required this.desc,
      required this.id,
      required this.answers})
      : super(key: key);

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Title: ",
                  style: TextStyle(color: Colors.grey, fontSize: 30),
                ),
                Container(
                    width: width * 0.8,
                    child: Text(
                      widget.title,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
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
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Container(
                    child: Text(widget.desc,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15)),
                    width: width * 0.8),
              ],
            ),
            SizedBox(
              height: height * 0.025,
            ),
            widget.images,
            SizedBox(
              height: height * 0.0125,
            ),
            Text(
              widget.answers.isEmpty ? "No answers available! " : "Answers: ",
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            ),
            SizedBox(
              height: height * 0.0125,
            ),
            Column()
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
