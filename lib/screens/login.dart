import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/screens/email_signup.dart';
import 'package:app/screens/email_signin.dart';
import 'package:app/screens/app.dart';
import 'package:app/providers/auth_service.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String loginStatus = ""; // inProgress, failed, success
  String? userId;
  User? user;

  Future<void> autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userIdStorage = prefs.getString('user_id');
    User? currentUser= FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      setState(() {
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
    final _auth = Provider.of<Authentication>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Image(image: AssetImage('assets/laura_logo_w.png'),
                width: 150,
                height: 150,
                fit: BoxFit.fill,
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
              padding: const EdgeInsets.all(16.0),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
