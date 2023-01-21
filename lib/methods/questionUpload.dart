import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeit/utils/constants.dart';

Future<void> uploadQuestion(String? ques, String? desc, List<String> imgUrls) async {
  if(ques == ""){
    ques = "EMPTY";
  }
  if(desc == ""){
    desc = "No Description";
  }
  await firestore.collection("questions").add(
    {
      "author_name": auth.currentUser!.displayName,
      "author_picture": auth.currentUser!.photoURL,
      "desc": desc,
      "question": ques,
      "img_urls": imgUrls,
      "answers": [],
      "dateTime" : Timestamp.now()
    },
  );
}