import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "./screens/login.dart";
import "./screens/app.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
  User? currentUser = FirebaseAuth.instance.currentUser;
  //bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Laura',
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      // home: !isLoggedIn ? Login(isLoggedIn) : App(isLoggedIn),
      home: (currentUser == null) ? const Login() : const App(),
    );
  }
}