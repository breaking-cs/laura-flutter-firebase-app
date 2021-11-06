import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:app/widgets/custom_app_bar.dart";
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
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
      padding: const EdgeInsets.all(30.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GridView.count(
            padding: const EdgeInsets.only(
              top: 70,
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
  String? currentTime = DateFormat('MM/dd EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15),
                        ),
                        const Text(
                          'Hello!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                        Text(
                          '$currentUserName 사장님,',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20),
                        ),
                        const Text(
                          '오늘도\n힘내세요!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    fit: StackFit.passthrough,
                    overflow: Overflow.visible,
                    children: [
                      Container(),
                      Positioned(
                        right: 20,
                        top: -170,
                        child: Container(
                          width: 170,
                          height: 170,
                          child: const Image(
                            image: AssetImage('assets/flower_w.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -10,
                        left: 20,
                        right: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                          width: 300,
                          height: 550,
                          child: Padding(
                            padding: EdgeInsets.all(20),

                            child: Text(
                              'Today,\n$currentTime',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const HomeCard(),
                ],
              ),
            );
          }),
    );
  }
}
