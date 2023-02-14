import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeit/utils/constants.dart';

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getQuestions(String collectionType) async {
  var data = await firestore.collection(collectionType).orderBy("dateTime", descending: true).get();
  return data.docs;
}