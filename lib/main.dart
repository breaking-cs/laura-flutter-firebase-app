import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Laura"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: IconButton(
              icon: Icon(Icons.home),
              onPressed: () => print("hello"),
              color: Colors.white)),
    ));
  }
}
