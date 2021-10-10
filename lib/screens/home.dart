import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.indigo,
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot){
              return Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Column(
                    children: [
                      Text("Hello!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40),
                      ),
                      Text("${currentUserName} 사장님,",
                        style: TextStyle(
                          color: Colors.white,
                            fontSize: 30),
                      ),
                      Text("오늘도\n힘내세요!",
                        style: TextStyle(
                          color: Colors.white,
                            fontSize: 20),
                      ),
                   ],
                ),
              );
            }
          )
    );
  }
}