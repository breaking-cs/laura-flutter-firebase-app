import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './email_signup.dart';
import './email_signin.dart';
import './app.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> checkAuthentication() async{
    _auth.authStateChanges().listen((user){
      if(user != null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => App()),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuthentication = await account!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    assert(!user!.isAnonymous);
    assert(await user!.getIdToken() != null);

    return user;
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
                    onPressed: () async {
                      try{
                        var user = await signInWithGoogle();
                        // requestLogIn("$user");
                      }catch (e) {

                      }
                    }
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
