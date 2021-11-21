import 'package:app/utils/date.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import "../screens/customers_tx.dart";
import '../screens/customer_tx_detail.dart';
import '../providers/transactions.dart';

class TxCard extends StatelessWidget {
  final Transaction data;
  final int index;
  final String customerId;
  const TxCard(
      {Key? key,
        required this.index,
        required this.customerId,
        required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formatDate(data.createdAt),
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(data.memo),
              ],
            ),
            onTap: () => {
              Navigator.of(context).pushNamed(TxDetail.routeName, arguments: data)
            },
          ),
        ),
        Positioned(
          right: 5.0,
          top: 5.0,
          child: GestureDetector(
            onTap: (){
              deleteTransaction(customerId, data.id, data.imgUrl);
            },
            child: const Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 12.0,
                backgroundColor: Colors.transparent,
                child: Icon(Icons.close, color: Colors.red),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
