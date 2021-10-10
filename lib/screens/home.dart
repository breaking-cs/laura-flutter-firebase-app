import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(
        bottom: 30,
        left: 10,
        right: 10,
      ),
      child: Text("Hello"),
      elevation: 5,
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text("Today: Date"),
          GridView.count(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            primary: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: const <Widget>[
              CustomCard(),
              CustomCard(),
              CustomCard(),
              CustomCard(),
            ],
          ),
          const ElevatedButton(
            onPressed: null,
            child: Text("더 보기"),
          ),
        ],
      ),
    );
  }
}

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
            child: const HomeCard(),
            elevation: 5,
          ),
        ),
      ],
    );
  }
}
