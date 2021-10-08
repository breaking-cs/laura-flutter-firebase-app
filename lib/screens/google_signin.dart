import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

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

/*
class GoogleSignIn extends StatefulWidget {
  @override
  _GoogleSignInState createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isLoggedIn = false;

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

    setState(() {
      isLoggedIn = true;
    });

    return user;
  }
  @override
  Widget build(BuildContext context) {
    return Text(
      'Login Screen',
      textAlign: TextAlign.center,
    );
  }
}

 */