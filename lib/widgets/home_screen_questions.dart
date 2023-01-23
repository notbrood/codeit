import 'package:codeit/screens/answers_screen.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

Widget homeScreenQuestions(
        String ques,
        String desc,
        String author,
        String picUrl,
        List<dynamic> imgUrls,
        String id,
        List<dynamic> answers,
        BuildContext context) =>

    ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(15),
        color: Colors.white.withOpacity(0.05),
        shadowColor: Colors.white10,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(picUrl),
                    ),
                    Text(
                      ReCase(author.substring(author.length - 10, author.length)).originalText.toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ques,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      desc,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onPressed: () {
        List<Widget> p = [];
        for (var imgLink in imgUrls){
          p.add(Image.network(imgLink, height: 0.25*MediaQuery.of(context).size.height));
          p.add(SizedBox(height: MediaQuery.of(context).size.height*0.025));
        }
        Column col = Column(children: p,);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnswerScreen(
                    title: ques,
                    images: col,
                    desc: desc,
                    id: id,
                    answers: answers)));
      },
    );
