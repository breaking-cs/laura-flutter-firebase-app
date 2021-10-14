import 'package:flutter/material.dart';
import '../models/transaction.dart';

class Transactions with ChangeNotifier {
  // deep final이 아니다
  final List<Transaction> _items = List<Transaction>.generate(
    1,
    (index) => Transaction(
      id: index,
      customerId: index + 1,
      amount: 1000,
      date: DateTime.now(),
      imgUrl: 'https://picsum.photos/400',
    ),
  );

  List<Transaction> get items {
    return [..._items];
  }

  void addTransaction({
    required customerId,
    required amount,
    required date,
    required imgUrl,
  }) {
    _items.add(Transaction(
      id: _items.length,
      customerId: customerId,
      amount: amount,
      date: date,
      imgUrl: imgUrl,
    ));
    notifyListeners();
  }
}
