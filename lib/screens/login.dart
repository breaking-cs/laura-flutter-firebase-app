import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './email_signup.dart';
import './email_signin.dart';
import './app.dart';
import '../utils/auth_service.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  /*
  final bool isLoggedIn;
  const Login(this.isLoggedIn);
   */

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //late bool isLoggedIn;
  String loginStatus = ""; // inProgress, failed, success
  String? userId;
  User? user;


  Future<void> autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userIdStorage = prefs.getString('user_id');
    User? currentUser= FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      setState(() {
        //isLoggedIn = true;
        user = currentUser;
        userId = userIdStorage;
      });
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

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
              child: Text('LAURA',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('FOR YOUR ONE AND ONLY,\nFLOWER SHOP',
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
                          MaterialPageRoute(builder: (context) => const EmailSignIn()),
                          //MaterialPageRoute(builder: (context) => EmailSignIn(isLoggedIn)),
                        );
                      }
                  ),
                  SignInButton(
                      Buttons.Google,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        await Authentication.signInWithGoogle().then((result) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const App()),
                            //MaterialPageRoute(builder: (context) => App(isLoggedIn)),
                          );
                        });
                      },
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: const Text("Don't have an account? SIGN UP!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    decoration: TextDecoration.underline),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmailSignUp()),
                  //MaterialPageRoute(builder: (context) => EmailSignUp(isLoggedIn)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
