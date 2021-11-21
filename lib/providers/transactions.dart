import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../models/transaction.dart' as tx;
import 'package:path/path.dart';

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

Future<String> uploadFile(String customerId, File imageFile) async {
  User user = FirebaseAuth.instance.currentUser!;

  firebase_storage.TaskSnapshot uploadTask;
  String fileName = basename(imageFile.path);
  // Create a Reference to the file
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref()
      .child('${user.uid}/$customerId-$fileName');

  uploadTask = await ref.putFile(imageFile);

  String downloadURL = await uploadTask.ref.getDownloadURL();

  return downloadURL;
}

Future<void> addTransactions(
  String customerId, {
  required int amount,
  required String memo,
  File? imageFile,
}) async {
  late final CollectionReference? txs;
  FirebaseFirestore _fireStoreDatabase = FirebaseFirestore.instance;
  txs = _fireStoreDatabase.collection('tx/${customerId}/purchase');

  // upload image
  String? link;
  if (imageFile != null) {
    link = await uploadFile(customerId, imageFile);
  }

  return txs
      .add({
        'amount': amount,
        "memo": memo,
        "imgUrl": link ?? "",
        'createdAt': Timestamp.now(),
      })
      .then((val) => print('customer Added'))
      .catchError((error) => print("Failed to Add Customers: $error"));
}

Future<void> deleteTransaction(
    String customerId, String hashcode, String imgUrl) async {
  // 개별 사진을 지움
  await firebase_storage.FirebaseStorage.instance.refFromURL(imgUrl).delete();

  // transaction 자체를 지움
  late final CollectionReference? txs;
  FirebaseFirestore _fireStoreDatabase = FirebaseFirestore.instance;
  txs = _fireStoreDatabase.collection('tx/$customerId/purchase');

  return txs
      .doc(hashcode.toString())
      .delete()
      .then((value) => print("User Deleted"))
      .catchError((error) => print("Failed to delete user: $error"));
}

Future<List<String>> listTxImages() async {
  User user = FirebaseAuth.instance.currentUser!;
  firebase_storage.ListResult result =
      await firebase_storage.FirebaseStorage.instance.ref(user.uid).listAll();

  Iterable<Future<String>> mappedList =
      result.items.map((firebase_storage.Reference ref) async {
    return await ref.getDownloadURL();
  });

  Future<List<String>> futureList = Future.wait(mappedList);
  List<String> urlList = await futureList;
  return urlList;
}
