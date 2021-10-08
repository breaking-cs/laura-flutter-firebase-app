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
  final _formKey = GlobalKey<FormState>();
  final _userId = TextEditingController();
  final _userPassword = TextEditingController();
  Future? _loginFuture;

  /*
  loginUser() async {
    await widget.requestLogIn(_userId.text);

    _userId.clear();
    _userPassword.clear();
  }
   */

  @override
  Widget build(BuildContext context) {
    // TODO: InProgress, Failed일때 처리 해줘야함
    //print(widget.loginStatus);

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16.0),
              Text(
                'Login Screen',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36.0),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _userId,
                            decoration: const InputDecoration(
                              labelText: 'Id',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                // onPressed: loginUser,
                                onPressed: null,
                                child: const Text('LOGIN'),
                              ),
                              ElevatedButton(
                                onPressed: null,
                                child: const Text('SIGN UP'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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