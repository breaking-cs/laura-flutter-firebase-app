import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "./screens/app.dart";
import "./screens/login.dart";
import "./screens/home.dart";


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool isLoggedIn = false;
  String loginStatus = ""; // inProgress, failed, success
  String? userId;

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userIdStorage = prefs.getString('user_id');

    if (userIdStorage != null) {
      setState(() {
        isLoggedIn = true;
        userId = userIdStorage;
      });
      return;
    }
  }

  Future requestLogIn(String userIdInput) async {
    setState(() {
      loginStatus = "inProgress";
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //  TODO: 여기서 api 처리해줘야함, 에러처리도 여기서 해야할듯, 에러인 경우 error status를 보내줘야함
    // TODO 비동기 처리하고, isLogInFailed, 를 내려주는 방식으로 일단 가쟝
    return Future.delayed(const Duration(seconds: 2), () {
      // success라고 가정
      prefs.setString('user_id', userIdInput);
      setState(() {
        isLoggedIn = true;
        userId = userIdInput;
        // loginStatus = "success";
      });
    });
  }

  Future requestLogOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.delayed(const Duration(seconds: 2), () {
      // success라고 가정
      prefs.remove("user_id");
      setState(() {
        isLoggedIn = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laura',
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      home: !isLoggedIn ? Login() : App(requestLogOut),
    );
  }
}