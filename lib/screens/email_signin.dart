import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  //late bool isLoggedIn;
  late String loginStatus;
  Future? _loginFuture;
  String? userId;

  Future<void> requestLogIn() async {
    setState(() {
      loginStatus = "inProgress";
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //  TODO: 여기서 api 처리해줘야함, 에러처리도 여기서 해야할듯, 에러인 경우 error status를 보내줘야함
    // TODO 비동기 처리하고, isLogInFailed, 를 내려주는 방식으로 일단 가쟝
    // success라고 가정
    prefs.setString('user_id', _userEmail.text.trim());

    await Authentication.signInWithEmail(
        _userEmail.text.trim(),_userPassword.text.trim())
        .then((result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const App()),
      );
    }
    );

    setState(() {
      userId = _userEmail.text.trim();
      loginStatus = "success";
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: InProgress, Failed일때 처리 해줘야함

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign In",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    ),
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
                              text: 'LOGIN',
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
                                  requestLogIn();
                                }
                              }
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