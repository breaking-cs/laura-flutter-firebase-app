import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
            top: 20,
            bottom: 20,
          ),
          padding: const EdgeInsets.all(20.0),
          child: const Text("Hello!"),
        ),
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.only(
              bottom: 30,
              left: 10,
              right: 10,
            ),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              child: Text("Chart"),
            ),
            elevation: 5,
          ),
        ),
      ],
    );
  }
}
