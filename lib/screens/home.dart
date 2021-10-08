import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot){
              return Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Column(
                    children: [
                      Text("Hello!",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            // color: Colors.white,
                            fontSize: 40),
                      ),
                      Text("${FirebaseAuth.instance.currentUser!.displayName} 사장님,",
                        style: TextStyle(
                          // color: Colors.white,
                            fontSize: 30),
                      ),
                      Text("오늘도\n힘내세요!",
                        style: TextStyle(
                          // color: Colors.white,
                            fontSize: 20),
                      ),
                   ],
                ),
              );
            }
          )
        )
    );
  }
}