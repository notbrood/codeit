import 'package:codeit/screens/answers_screen.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

Widget homeScreenQuestions(
        String ques,
        String desc,
        String author,
        String type,
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
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        picUrl,
                        height: 50,
                      ),
                    ),
                  ),
                  type != "nonVIT" ? Text(
                    ReCase(author.substring(author.length - 10, author.length)).originalText.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                  ) : Text(
                    author,
                    style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Q. $ques",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Text(
                            desc,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      onPressed: () {
        List<Widget> p = [];
        for (var imgLink in imgUrls) {
          p.add(Image.network(imgLink,
              height: 0.25 * MediaQuery.of(context).size.height));
          p.add(SizedBox(height: MediaQuery.of(context).size.height * 0.025));
        }
        Column col = Column(
          children: p,
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AnswerScreen(type: type, images: col, id: id)));
      },
    );
