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
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 30),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text("고객: ${info.name}"),
              Text("전화번호: ${info.phoneNumber}"),
              Text("CreatedAt: ${formatDate(info.createdAt)}"),
            ],
          ),
        ),
      ),
    );
  }
}
