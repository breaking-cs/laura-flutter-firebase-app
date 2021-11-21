import 'package:app/screens/settings.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  Future? _profileFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: _profileFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 60),
                              Text(
                                'User name',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _userName,
                                keyboardType: TextInputType.text,
                                maxLength: 10,
                                textCapitalization: TextCapitalization.characters,
                                decoration: const InputDecoration(
                                  hintText:'Enter new username',
                                  hintStyle: TextStyle(
                                      color: Colors.indigo
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
                              SizedBox(height: 60),
                              IconsButton(
                                padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
                                text: 'Save',
                                color: Colors.indigo,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.circular(10),
                                ),
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      await _auth.currentUser!.updateDisplayName( _userName.text.trim());
                                      _auth.currentUser!.reload();
                                      Dialogs.materialDialog(
                                        title: 'Updated!',
                                        context: context,
                                        actions: [
                                          IconsButton(
                                            text: 'Check',
                                            iconData: Icons.check,
                                            color: Colors.redAccent,
                                            textStyle: const TextStyle(color: Colors.white),
                                            iconColor: Colors.white,
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const Settings()),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
        ),
      ),
    );
  }
}