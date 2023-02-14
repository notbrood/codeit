import 'package:codeit/screens/home_screen.dart';
import 'package:codeit/screens/non_vit_screen.dart';
import 'package:codeit/screens/real_home_screen.dart';
import 'package:codeit/utils/colors.dart';
import 'package:codeit/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "assets/images/codeitlogo.png",
                height: 100,
              ),
              const Text(
                "codeit.",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontFamily: "Inter"),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  await logIn(context);
                },
                style: ElevatedButton.styleFrom(
                    elevation: 7,
                    backgroundColor: loginButtonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/googlelogo.png",
                      height: 15,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      "Login with Gmail.",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Let's get started!",
                style: TextStyle(
                  color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15,),
              const Text(
                "Join the discussion with fellow VITians!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 100,),
            ],
          ),
        ),
    );
  }

  Future<void> logIn(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null && googleSignInAccount.email.contains('@vitbhopal.ac.in')) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      await auth.signInWithCredential(authCredential);
      Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const RealHomeScreen()));
    }
    else if(googleSignInAccount != null){
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      await auth.signInWithCredential(authCredential);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const NonVITScreen()));
    }
    else{
      final x = SnackBar(content: const Text("There was an error!"), backgroundColor: loginButtonColor.withOpacity(0.1),);
      ScaffoldMessenger.of(context).showSnackBar(x);
    }
  }

}
