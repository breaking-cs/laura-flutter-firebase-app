import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import "../models/customer.dart" as cust;

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final custs = Provider.of<List<cust.Customer>?>(context);

    /*
    int sum = custs == null
        ? 0
        : custs.fold(0, (acc, elem) {
      return acc + elem.totalAmount;
    });

     */

    return Container(
      padding: const EdgeInsets.all(30.0),
      width: double.infinity,
      child: GridView.count(
            padding: const EdgeInsets.only(
              top: 70,
            ),
            primary: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2),
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(
                  bottom: 30,
                  left: 10,
                  right: 10,
                ),
                color: Colors.redAccent,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${custs == null ? 0 : custs.length}',
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),),
                      const SizedBox(height: 10),
                      const Text('Customers',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,),),
                    ],
                  ),
                  padding: const EdgeInsets.all(18),
                ),
                elevation: 5,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(
                  bottom: 30,
                  left: 10,
                  right: 10,
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('333,000', //$sum
                        style: const TextStyle(fontSize: 30),),
                      const SizedBox(height: 10),
                      const Text('Sales',
                        style: TextStyle(fontSize: 15),),
                    ],
                  ),
                  padding: const EdgeInsets.all(18),
                ),
                elevation: 5,
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
                        const SizedBox(height: 50,),
                        const Text(
                          'Hello!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children:[
                            Text(
                            '$currentUserName',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              ' 사장님,',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50,),
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
                      const Positioned(
                        right: 20,
                        top: -140,
                        child: SizedBox(
                          width: 160,
                          height: 160,
                          child: Image(
                            image: AssetImage('assets/flower_w.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 20,
                        right: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                          height: 280,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5,),
                                const Text(
                                  'Today,',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  '$currentTime',
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                  const SizedBox(height: 18,),
                  const HomeCard(),
                ],
              ),
            );
          }),
    );
  }
}
