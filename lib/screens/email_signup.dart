import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import "../screens/login.dart";
import "../screens/email_signin.dart";
import '../utils/auth_service.dart';

class EmailSignUp extends StatefulWidget {
  const EmailSignUp({Key? key}) : super(key: key);

  /*
  final bool isLoggedIn;
  const EmailSignUp(this.isLoggedIn);
   */

  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  final _formKey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _userEmail = TextEditingController();
  final _userPassword = TextEditingController();
  // late bool isLoggedIn;

  Future<void> requestSignUp() async {
    await Authentication.signUpWithEmail(
        _userName.text.trim(), _userEmail.text.trim(),_userPassword.text.trim())
        .then((result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmailSignIn()),
        //MaterialPageRoute(builder: (context) => EmailSignIn(isLoggedIn)),
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _userName,
                keyboardType: TextInputType.text,
                maxLength: 10,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Enter your username',
                  suffixIcon: Icon(
                    Icons.account_circle,
                  ),
                ),
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _userEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Enter your email address',
                  suffixIcon: Icon(
                    Icons.email,
                  ),
                ),
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Enter your email address';
                  } else if (!input.contains('@')) {
                    return 'Please enter a valid email address!';
                  }
                  return null;
                },
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              TextFormField(
                controller: _userPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter your password',
                  suffixIcon: Icon(
                    Icons.lock,
                  ),
                ),
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Enter your password';
                  } else if (input.length < 6) {
                    return 'Password must be at least 6 characters!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              IconsButton(
                padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
                text: 'REGISTER',
                color: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadiusDirectional.circular(10),
                ),
                textStyle: const TextStyle(color: Colors.white,
                    fontSize: 20),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Dialogs.bottomMaterialDialog(
                        msg: 'Are you sure to sign up with the information?',
                        title: 'Sign Up',
                        context: context,
                        actions: [
                          IconsButton(
                            text: 'Cancel',
                            iconData: Icons.cancel_outlined,
                            color: Colors.grey,
                            textStyle: const TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          IconsButton(
                            text: 'Sign Up',
                            iconData: Icons.check,
                            color: Colors.indigo,
                            textStyle: const TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                            onPressed: () {
                              requestSignUp();
                              // TODO: Sing up이 완료됐다는 dialog
                            },
                          ),
                        ],
                    );
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              GestureDetector(
                child: const Text('Already have an account? CLICK HERE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.underline),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    // MaterialPageRoute(builder: (context) => Login(isLoggedIn)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}