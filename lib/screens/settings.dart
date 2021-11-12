import 'package:app/screens/edit_profile.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_dialogs/material_dialogs.dart';
import '../providers/auth_service.dart';
import './login.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> requestLogOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Future.delayed(const Duration(seconds: 2), () {
      prefs.remove("user_id");

      Authentication.signOut().then((res) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login()),
            (Route<dynamic> route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  Text(
                    'User name',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${currentUser!.displayName}',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Email',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${currentUser!.email}',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  SizedBox(height: 50),
                  IconsButton(
                    padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
                    text: 'Edit Profile',
                    color: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditProfile()),
                      );
                    },
                  ),
                ],
              ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Container(
            height: 10,
            color: Colors.black12,
            alignment: Alignment.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Text(
                  'Laura v1.0',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                SizedBox(height: 30),
                IconsButton(
                  padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
                  text: 'Logout',
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    side: BorderSide(color: Colors.grey),
                  ),
                  textStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20),
                  onPressed: () {
                    Dialogs.materialDialog(
                      msg: 'Are you sure to logout?',
                      title: 'Logout',
                      context: context,
                      actions: [
                        IconsButton(
                          text: 'Cancel',
                          iconData: Icons.cancel_outlined,
                          color: Colors.grey,
                          textStyle: const TextStyle(color: Colors.white),
                          iconColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        IconsButton(
                          text: 'Logout',
                          iconData: Icons.logout,
                          color: Colors.redAccent,
                          textStyle: const TextStyle(color: Colors.white),
                          iconColor: Colors.white,
                          onPressed: () {
                            requestLogOut();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


