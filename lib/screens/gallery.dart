import 'package:app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/transaction.dart';

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

  String formatDate(DateTime tx) {
    return "${tx.year.toString()}년 ${tx.month.toString()}월 ${tx.day.toString()}일";
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        var tx = transactions[index];

        return Card(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(tx.imgUrl),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomRight,
            child: Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 10),
              color: Colors.grey,
              height: 30,
              child: Text(
                tx.customerId.toString() + "번 고객님의 꽃",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
