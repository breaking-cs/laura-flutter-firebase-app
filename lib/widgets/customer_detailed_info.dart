// 고객 상단에 정보 보여주는곳
import 'package:flutter/material.dart';
import "../models/customer.dart";
import "../utils/date.dart";

class CustomerDetailedInfo extends StatelessWidget {
  final Customer info;
  const CustomerDetailedInfo({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children:[
                  Text("${info.name}",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),),
                  Text("  고객님",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),),
                ],
              ),
              Text("CreatedAt: ${formatDate(info.createdAt)}"),
            ],
          ),
        ),
    );
  }
}
