import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tx;
  const TransactionItem({
    Key? key,
    required this.tx,
  }) : super(key: key);

  String formatDate(DateTime tx) {
    return "${tx.year.toString()}년 ${tx.month.toString()}월 ${tx.day.toString()}일";
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.only(
          right: 10,
        ),
        child: Text(
          formatDate(tx.date),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      child: Image.network(tx.imgUrl),
    );
  }
}
