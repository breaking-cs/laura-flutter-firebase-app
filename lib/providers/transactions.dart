import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../models/transaction.dart' as tx;

class TransactionStream {
  late final FirebaseFirestore _fireStoreDatabase;
  late String customerId;
  late final CollectionReference? txs;

  TransactionStream({required this.customerId}) {
    _fireStoreDatabase = FirebaseFirestore.instance;
    txs = _fireStoreDatabase.collection('tx/${customerId}/purchase');
  }

  Stream<List<tx.Transaction>> getTransationList() {
    if (txs == null) {
      return Stream.empty();
    } else {
      return txs!
          .orderBy(
        'createdAt',
        descending: false,
      )
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => tx.Transaction.fromJson(
          doc.data() as Map<String, dynamic>, doc.id))
          .toList());
    }
  }
}

Future<void> addTransactions(
    String customerId, {
      required int amount,
      required String memo,
      String imgUrl = "",
    }) async {
  late final CollectionReference? txs;
  FirebaseFirestore _fireStoreDatabase = FirebaseFirestore.instance;
  txs = _fireStoreDatabase.collection('tx/${customerId}/purchase');

  return txs
      .add({
    'amount': amount,
    "memo": memo,
    "imgUrl": imgUrl,
    'createdAt': Timestamp.now(),
  })
      .then((val) => print('customer Added'))
      .catchError((error) => print("Failed to Add Customers: $error"));
}

Future<void> deleteTransaction(String customerId, String hashcode) {
  late final CollectionReference? txs;
  FirebaseFirestore _fireStoreDatabase = FirebaseFirestore.instance;
  txs = _fireStoreDatabase.collection('tx/${customerId}/purchase');

  return txs
      .doc(hashcode.toString())
      .delete()
      .then((value) => print("User Deleted"))
      .catchError((error) => print("Failed to delete user: $error"));
}
