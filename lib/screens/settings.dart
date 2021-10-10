import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './login.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Logout",
              style: TextStyle(
                  fontSize: 30),
              ),
            onTap: () {
              FirebaseAuth _auth = FirebaseAuth.instance;
              _auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                        (Route<dynamic> route) => false);
              });
            },
          ),
          ],
        ),
    );
  }
}
