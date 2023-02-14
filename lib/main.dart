import 'package:codeit/screens/first_screen.dart';
import 'package:codeit/screens/home_screen.dart';
import 'package:codeit/screens/non_vit_screen.dart';
import 'package:codeit/screens/real_home_screen.dart';
import 'package:codeit/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Codeit',
      routes: {
        'home': (context) => const RealHomeScreen(),
        'first': (context) => const LoginScreen(),
        'nonvit': (context) => const NonVITScreen()
      },
      home: auth.currentUser != null
          ? auth.currentUser!.email!.contains("@vitbhopal.ac.in")
              ? const RealHomeScreen()
              : const NonVITScreen()
          : const LoginScreen(),
    );
  }
}
