import 'package:flutter/material.dart';
import "./screens/home.dart";
import "./screens/customers.dart";
import "./screens/gallery.dart";
import "./screens/settings.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final _tabs = const [
    Center(child: Home()),
    Center(child: Customers()),
    Center(child: Gallery()),
    Center(child: Settings()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Laura"),
              centerTitle: true,
            ),
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
                })));
  }
}
