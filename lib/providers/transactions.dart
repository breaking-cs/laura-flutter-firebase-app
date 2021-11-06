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
