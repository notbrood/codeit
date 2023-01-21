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
            Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 30),),
            Text(widget.desc, style: const TextStyle(color: Colors.white, fontSize: 15)),
            widget.images
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
