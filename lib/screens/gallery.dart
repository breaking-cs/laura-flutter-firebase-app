import 'package:app/models/transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../components/transaction_item.dart';

class Gallery extends StatelessWidget {
  Gallery({Key? key}) : super(key: key);

  final List<Transaction> transactions = List<Transaction>.generate(
    100,
    (index) => Transaction(
      id: index,
      customerId: index + 1,
      amount: 1000,
      date: DateTime.now(),
      imgUrl: 'https://picsum.photos/400',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
      ),
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        return TransactionItem(tx: transactions[index]);
      },
    );
  }
}
