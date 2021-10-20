import 'package:app/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_dialogs/material_dialogs.dart';
import '../utils/auth_service.dart';
import './login.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //late bool isLoggedIn;

  Future<void> requestLogOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Future.delayed(const Duration(seconds: 2), () {
      prefs.remove("user_id");

      Authentication.signOut().then((res) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login()),
            // MaterialPageRoute(builder: (context) => Login(isLoggedIn)),
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
          ListTile(
            title: const Text('Edit Profile'),
            onTap: () {
              // TODO: editProfile();
            },
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout,),
            onTap: () {
              Dialogs.bottomMaterialDialog(
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
    );
  }
}