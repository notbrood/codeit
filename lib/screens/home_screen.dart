import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeit/methods/get_questions.dart';
import 'package:codeit/widgets/home_screen_questions.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  final screenType;
  const HomeScreen({Key? key, required this.screenType}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    () async {
      var permissionStatus = await Permission.storage.status;
      if (permissionStatus != PermissionStatus.granted) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        setState(() {
          permissionStatus = permissionStatus;
        });
      }
    };
  }
  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
        future: getQuestions(widget.screenType),
        builder: (
          context,
          snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              if(snapshot.data!.isEmpty){
                return const Text("NO QUESTIONS", style: TextStyle(color: Colors.white),);
              }
              return ListView(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: snapshot.data!.map(
                  (DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return homeScreenQuestions(
                        data["question"],
                        data["desc"],
                        data["author_name"],
                        widget.screenType,
                        data["author_picture"],
                        data["img_urls"],
                        document.id,
                        data["answers"],
                        context);
                  },
                ).toList(),
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
    );
  }
}

