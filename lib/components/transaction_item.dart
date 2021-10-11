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
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        // leading: IconButton(icon: Icon(Icons.favorite), onPressed: null),
        // trailing: IconButton(icon: Icon(Icons.shopping_cart), onPressed: null),
        title: Text(
          formatDate(tx.date),
          textAlign: TextAlign.center,
        ),
      ),
      child: Image.network(
        tx.imgUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
