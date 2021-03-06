import 'package:app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/screens/email_signup.dart';
import '../providers/auth_service.dart';
import './app.dart';

class EmailSignIn extends StatefulWidget {
  const EmailSignIn({Key? key}) : super(key: key);

  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final _formKey = GlobalKey<FormState>();
  final _userEmail = TextEditingController();
  final _userPassword = TextEditingController();
  late String loginStatus;
  Future? _loginFuture;
  String? userId;

  Future<void> requestLogIn() async {
    setState(() {
      loginStatus = "inProgress";
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', _userEmail.text.trim());

    var result = await Authentication.signInWithEmail(
        _userEmail.text.trim(), _userPassword.text.trim());

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(result[1])));

    if (result[0] == "success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const App()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '로그인',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
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
                        controller: _userEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.indigo),
                          hintText: 'Enter your email address',
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.indigo, width: 2.0),
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
                      TextFormField(
                        controller: _userPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.indigo),
                          hintText: 'Enter your password',
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.indigo, width: 2.0),
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
                      const SizedBox(height: 60),
                      IconsButton(
                          padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
                          text: 'Login',
                          color: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(10),
                          ),
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              requestLogIn();
                            }
                          }),
                      const SizedBox(height: 30),
                      GestureDetector(
                        child: const Text(
                          "Don't have an account? SIGN UP!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EmailSignUp()),
                          );
                        },
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
