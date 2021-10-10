import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "./home.dart";
import "./customers.dart";
import "./gallery.dart";
import "./settings.dart";

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  final _tabs = const [
    Center(child: Home()),
    Center(child: Customers()),
    Center(child: Gallery()),
    Center(child: Settings()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "Customers",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: "Gallery",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            }
        ),
    );
  }
}
