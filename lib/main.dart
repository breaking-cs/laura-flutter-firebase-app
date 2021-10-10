import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "./screens/login.dart";
import "./screens/home.dart";
import "./screens/app.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laura',
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      home: Login(),
    );
  }
}