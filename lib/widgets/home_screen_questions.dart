import 'package:flutter/material.dart';

Widget homeScreenQuestions(String ques, String desc, String author, String picUrl){
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(border: Border.all(color: Colors.white),),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Image.network(picUrl),
              Text(author, style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Text(ques, style: const TextStyle(color: Colors.white),),
              Text(desc, style: const TextStyle(color: Colors.white),)
            ],
          ),
        )
      ],
    ),
  );
}