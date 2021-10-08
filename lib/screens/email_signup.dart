import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailSignUp extends StatefulWidget {
  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}


class _EmailSignUpState extends State<EmailSignUp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16.0),
              Text(
                'Signup Screen',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}