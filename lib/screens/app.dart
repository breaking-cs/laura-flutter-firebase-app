import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/customers_main.dart';
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
    Center(child: CustomerMain()),
    Center(child: Gallery()),
    Center(child: Settings()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
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
    /*
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: Theme.of(context).primaryColor,
        items: const <BottomNavigationBarItem>[
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
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: Home());
            });
            break;
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: CustomerMain());
            });
            break;
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: Gallery());
            });
            break;
          case 3:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(child: Settings());
            });
            break;
          default:
            return const CupertinoTabView();
        }
      },
    );

     */

  }
}
