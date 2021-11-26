import 'package:app/models/customer.dart';
import 'package:app/providers/customers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../models/transaction.dart" as tx;
import "../models/customer.dart" as cust;

class CustomerMainInfo extends StatefulWidget {
  const CustomerMainInfo({Key? key}) : super(key: key);

  @override
  _CustomerMainInfoState createState() => _CustomerMainInfoState();
}

class _CustomerMainInfoState extends State<CustomerMainInfo> {
  late final Customer customer;

  @override
  Widget build(BuildContext context) {
    final txs = Provider.of<List<tx.Transaction>?>(context);

    int sum = txs == null
        ? 0
        : txs.fold(0, (acc, elem) {
      return acc + elem.amount;
    });

    /*
    setState((){
      updateCustomerAmount(
        totalAmount: sum,
      );
    });
     */

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${txs == null ? 0 : txs.length} 회',
          style: const TextStyle(
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
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
