import 'package:flutter/material.dart';
import "./home.dart";
import "./customers.dart";
import "./gallery.dart";
import "./settings.dart";

class App extends StatefulWidget {
  final Function requestLogOut;

  // ignore: use_key_in_widget_constructors
  const App(this.requestLogOut);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 2;

  final _tabs = [
    Center(child: Home()),
    Center(child: Customers()),
    Center(child: Gallery()),
    Center(child: Settings()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Laura"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Open shopping cart',
              onPressed: () {
                widget.requestLogOut();
              },
            ),
          ],
        ),
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
            }));
  }
}
