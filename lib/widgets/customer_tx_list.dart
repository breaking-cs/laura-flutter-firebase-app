import 'package:flutter/material.dart';
import '../providers/transactions.dart';
import "../models/customer.dart";
import "../screens/customers_tx_add.dart";

class CustomerTxList extends StatelessWidget {
  final Customer info;
  const CustomerTxList({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("구매 목록이 여기 올것"),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              CustomersTxAdd.routeName,
            );
          },
          child: const Text("Add History"),
        )
      ],
    );
  }
}
