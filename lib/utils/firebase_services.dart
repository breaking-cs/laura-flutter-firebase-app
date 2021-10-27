import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/customer.dart';

class FirebaseServices {
  FirebaseFirestore _fireStoreDatabase = FirebaseFirestore.instance;

  Stream<List<Customer>> getCustomerList(String? uid) {
    if (uid != null) {
      return _fireStoreDatabase
          .collection('users/$uid/customers')
          .orderBy('createdAt', descending: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Customer.fromJson(doc.data()))
              .toList());
    } else {
      return const Stream.empty();
    }
  }
}
