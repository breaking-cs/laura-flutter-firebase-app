import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailSignIn extends StatefulWidget {
  /*
  final Function requestLogIn;
  final String loginStatus;

  // ignore: use_key_in_widget_constructors
  const EmailSignIn(this.requestLogIn, this.loginStatus);
   */

  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _userId = TextEditingController();
  final _userPassword = TextEditingController();
  late String _email, _passwaord;
  Future? _loginFuture;

  loginUser() async {
    //await widget.requestLogIn(_userId.text);

    _userId.clear();
    _userPassword.clear();
  }

  Future signInWithEmail(String email, String password) async {
    try{
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Sign in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: InProgress, Failed일때 처리 해줘야함
    //print(widget.loginStatus);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In",
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
              FutureBuilder(
                future: _loginFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _userId,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            // validator: _validateEmail,
                          ),
                          TextFormField(
                            controller: _userPassword,
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
                              borderRadius:BorderRadiusDirectional.circular(10),
                            ),
                            onPressed: (){
                                    // signUpWithEmail();
                            },
                            child: Text("LOGIN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                  );
                },
              ),
            ],
          ),
        ),
    );
  }
}