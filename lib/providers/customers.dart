import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/customer.dart';

class CustomerStream {
  final FirebaseFirestore _fireStoreDatabase = FirebaseFirestore.instance;
  final String? uid = FirebaseAuth.instance.currentUser!.uid;

  Stream<List<Customer>> getCustomerList() {
    if (uid != null) {
      return _fireStoreDatabase
          .collection('users/$uid/customers')
          .orderBy('createdAt', descending: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Customer.fromJson(doc.data(), doc.id))
              .toList());
    } else {
      return const Stream.empty();
    }
  }
}

Future<void> addCustomers({
  required String name,
}) {
  final String? uid = FirebaseAuth.instance.currentUser!.uid;

  if (uid != null) {
    CollectionReference? customers =
        FirebaseFirestore.instance.collection('users/$uid/customers');

    return customers
        .add({
          'name': name,
          'createdAt': Timestamp.now(),
        })
        .then((val) => print('customer Added'))
        .catchError((error) => print("Failed to Add Customers: $error"));
  } else {
    return Future.value();
  }
}

Future<void> deleteCustomer(String hashcode) {
  final String? uid = FirebaseAuth.instance.currentUser!.uid;

  if (uid != null) {
    CollectionReference? customers =
        FirebaseFirestore.instance.collection('users/$uid/customers');

    print(hashcode);
    return customers
        .doc(hashcode.toString())
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  } else {
    return Future.value();
  }
}
