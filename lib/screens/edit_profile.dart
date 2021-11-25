import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'app.dart';

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
    void handleUserInput() async {
      if (_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Updated username')));

        _formKey.currentState!.save();
        await _auth.currentUser!.updateDisplayName( _userName.text.trim());

        _auth.currentUser!.reload();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const App()),
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(
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
                              const SizedBox(height: 60),
                              const Text(
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
                              const SizedBox(height: 60),
                              IconsButton(
                                padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
                                text: 'Save',
                                color: Colors.indigo,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.circular(10),
                                ),
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),
                                onPressed: handleUserInput,
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
    );
  }
}