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
      child: Image.network(tx.imgUrl),
    );
  }
}
