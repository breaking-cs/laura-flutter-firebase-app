import 'package:flutter/material.dart';
import "./screens/app.dart";
import "./screens/login.dart";

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: !isLoggedIn ? const Login() : const App(),
    );
  }
}
