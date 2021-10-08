import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import './email_signup.dart';
import './email_signin.dart';
import './google_signin.dart';

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  bool isLoggedIn = false;
  String loginStatus = ""; // inProgress, failed, success
  String? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("LAURA",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("FOR YOUR ONE AND ONLY,\nFLOWER SHOP",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SignInButtonBuilder(
                      text: 'Sign in with Email',
                      icon: Icons.email,
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EmailSignIn()),
                        );
                      }
                  ),
                  SignInButton(
                    Buttons.Google,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: (){
                      signInWithGoogle();
                      /*
                      setState(() {
                        isLoggedIn = true;
                      });
                      */
                    }
                    /*
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GoogleSignIn()),
                      );
                    },
                     */
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Text("Don't have an accout? SIGN UP!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    decoration: TextDecoration.underline),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmailSignUp()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}