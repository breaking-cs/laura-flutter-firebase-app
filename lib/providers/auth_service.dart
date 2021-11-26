import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication with ChangeNotifier {
  Authentication({auth}) : _auth = auth ?? FirebaseAuth.instance;
  final FirebaseAuth _auth;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  static Future<String?> signUpWithEmail(
      String name, String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = credential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = _auth.currentUser;

      return "Sign up successful :$user";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        return e.message;
      }
    }
  }

  static Future<List> signInWithEmail(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = credential.user;
      return ["success", "Sign in successful: ${user?.displayName}"];
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return ["error", 'Wrong email or password provided.'];
      } else {
        return ["error", 'Unknown Error'];
      }
    }
  }

  static Future<String?> signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuthentication =
          await account!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken);

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);

      User? currentUser = await _auth.currentUser;
      assert(user!.uid == currentUser!.uid);

      return "Sign in successful in google :$user";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static Future<void> signOut() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await _auth.signOut();
      await googleSignIn.signOut();

      print("User Sign Out");
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = _auth.currentUser;

    return refreshedUser;
  }
}
