import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "./screens/login.dart";
import "./screens/app.dart";
import './screens/customers_tx.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = currentUser == null;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
        title: 'Laura',
        theme: ThemeData(
          fontFamily: 'OpenSans',
          primaryColor: Colors.indigo,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.teal, fontSize: 30),
            bodyText2: TextStyle(color: Colors.indigo, fontSize: 20),
            subtitle1: TextStyle(
                color: Colors.blue, fontSize: 50, fontWeight: FontWeight.bold),
          ),
        ),
        home: isLoggedIn ? const Login() : const App(),
        routes: {
          CustomersTransaction.routeName: (context) =>
              const CustomersTransaction(),
        });
  }
}
