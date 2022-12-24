import 'package:codeit/utils/colors.dart';
import 'package:codeit/utils/constants.dart';
import 'package:codeit/widgets/home_screen_questions.dart';
import 'package:flutter/material.dart';
import 'package:stretchy_header/stretchy_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(15),
        padding: EdgeInsets.zero,
        child: CircleAvatar(
            radius: 30,
            backgroundColor: loginButtonColor,
            child: IconButton(
              iconSize: 40,
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )),
      ),
      body: StretchyHeader.singleChild(
        headerData: HeaderData(
            header: AppBar(
              backgroundColor: bgColor,
              leading: Image.asset(
                "assets/images/codeitlogo.png",
                height: 40,
              ),
              title: const Text(
                "Home",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
              titleSpacing: 0,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            headerHeight: 80),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    buttonPressed("AIML");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: loginButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text("AIML"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: loginButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    buttonPressed("C++");
                  },
                  child: const Text("C++"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: loginButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    buttonPressed("Python");
                  },
                  child: const Text("Python"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: loginButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    buttonPressed("Dart");
                  },
                  child: const Text("Dart"),
                ),
              ],
            ),
            homeScreenQuestions()
          ],
        ),
      ),
    );
  }

  void buttonPressed(String text) {

  }
}
