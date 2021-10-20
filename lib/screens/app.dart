import 'package:flutter/material.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/customers.dart';
import 'package:app/screens/gallery.dart';
import 'package:app/screens/settings.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  final _tabs = [
    Center(child: Home()),
    Center(child: Customers()),
    Center(child: Gallery()),
    Center(child: Settings()),
    // Center(child: Settings(isLoggedIn)),
  ];

  @override
  Widget build(BuildContext context) {
    // Todo: https://www.youtube.com/watch?v=qj7jcuU2Z10 Navigation component 구성
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              label: "Customers",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.camera,
              ),
              label: "Gallery",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: "Settings",
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
