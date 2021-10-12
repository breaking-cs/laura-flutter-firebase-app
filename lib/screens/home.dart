import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "../components/custom_app_bar.dart";

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
      child: Container(
        child: Text("Hello"),
        padding: const EdgeInsets.all(10),
      ),
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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? currentUserName = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Home"),
      backgroundColor: Colors.indigo,
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$currentUserName 사장님,',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    const Text(
                      '오늘도\n힘내세요!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    const HomeCard(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
