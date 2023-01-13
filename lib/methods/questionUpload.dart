import 'package:codeit/utils/constants.dart';

Future<void> uploadQuestion(String? ques, String? desc) async {
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
      "description": desc,
      "question": ques,
      "answers": []
    },
  );
}