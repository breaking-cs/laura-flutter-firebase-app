import 'package:app/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import "../screens/login.dart";
import "../screens/email_signin.dart";
import '../providers/auth_service.dart';

class EmailSignUp extends StatefulWidget {
  const EmailSignUp({Key? key}) : super(key: key);

  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  final _formKey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _userEmail = TextEditingController();
  final _userPassword = TextEditingController();

  Future<void> requestSignUp() async {
    await Authentication.signUpWithEmail(
        _userName.text.trim(), _userEmail.text.trim(),_userPassword.text.trim())
        .then((result) {
          Dialogs.materialDialog(
            title: 'Signed up!',
            context: context,
            actions: [
              IconsButton(
                text: 'Check',
                iconData: Icons.check,
                color: Colors.redAccent,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EmailSignIn()),
                  );
                },
              ),
            ],
          );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : true,
      appBar: const CustomAppBar(title: "Sign Up"),
      body: Center(
      child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _userName,
                keyboardType: TextInputType.text,
                maxLength: 10,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.indigo),
                  hintText: 'Enter your username',
                  suffixIcon: Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:BorderSide(
                        color: Colors.indigo,
                        width: 2.0),
                  ),
                ),
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Enter your username';
                  }
                  return null;
                },
              ),
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
                    borderSide:BorderSide(
                        color: Colors.indigo,
                        width: 2.0),
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
              SizedBox(height: 20),
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
                    borderSide:BorderSide(
                        color: Colors.indigo,
                        width: 2.0),
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
              const Padding(
                padding: EdgeInsets.all(20),
              ),
              IconsButton(
                padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
                text: 'Register',
                color: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10),
                ),
                textStyle: const TextStyle(color: Colors.white,
                    fontSize: 20),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    requestSignUp();
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              GestureDetector(
                child: const Text('Already have an account? CLICK HERE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.underline),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      ),
      ),
    );
  }
}