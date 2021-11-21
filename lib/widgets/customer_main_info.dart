import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../models/transaction.dart" as tx;

class CustomerMainInfo extends StatelessWidget {
  const CustomerMainInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txs = Provider.of<List<tx.Transaction>?>(context);
    int sum = txs == null
        ? 0
        : txs.fold(0, (acc, elem) {
            return acc + elem.amount;
          });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${txs == null ? 0 : txs.length} 회',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 1,
          width: double.maxFinite,
          color: Colors.white54,
        ),
        const SizedBox(height: 10),
        Text(
          '$sum 원',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
