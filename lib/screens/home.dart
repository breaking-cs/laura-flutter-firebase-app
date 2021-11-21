import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final String content;

  const CustomCard({
    Key? key,
    required this.content,
  }) : super(key: key);

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
        child: Text(content,
          style: TextStyle(fontSize: 20),),
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
      //height: 10,
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
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2),
            children: const <Widget>[
              CustomCard(content: 'Visitors'),
              CustomCard(content: 'Sales'),
              CustomCard(content: 'Hello'),
              CustomCard(content: 'Hola'),
            ],
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
  String? currentTime = DateFormat('MM/dd EE').format(DateTime.now());

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
                          padding: EdgeInsets.all(20),
                        ),
                        const Text(
                          'Hello!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                        Row(
                          children:[
                            Text(
                            '$currentUserName',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' 사장님,',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),

                        const Padding(
                          padding: EdgeInsets.all(15),
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
                          height: 420,
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
