import 'package:flutter/material.dart';
import '../providers/transactions.dart';
import "../models/customer.dart";

class CustomerHistory extends StatelessWidget {
  final Customer info;
  const CustomerHistory({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: null,
          child: const Text("Add Image"),
        )
      ],
    );
  }
}
