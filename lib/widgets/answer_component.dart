import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class AnswerComponent extends StatelessWidget {
  String picUrl;
  String author;
  String ansText;
  AnswerComponent({Key? key, required this.picUrl, required this.author, required this.ansText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    child: Image.network(picUrl, height: 40,),
                  ),
                  Text(
                    ReCase(author).originalText.toUpperCase(),
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
                    ansText,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
