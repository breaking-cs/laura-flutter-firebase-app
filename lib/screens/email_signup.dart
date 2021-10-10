import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "../screens/login.dart";

class EmailSignUp extends StatefulWidget {
  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  Future signUpWithEmail(String email, String password) async {
    try{
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Sign up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign Up",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              //controller: _userId,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              // validator: _validateEmail,
            ),
            TextFormField(
              // controller: _userPassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              // validator: _validatePassword,
            ),
            TextFormField(
              // controller: _userPassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              // validator: _validatePassword,
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            RaisedButton(
                padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                color: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadiusDirectional.circular(10),
                ),
                onPressed: () {
                  // signUpWithEmail();
                },
                child: Text("REGISTER",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20),
                )),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            GestureDetector(
              child: Text("Already have an account? CLICK HERE",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    decoration: TextDecoration.underline),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}