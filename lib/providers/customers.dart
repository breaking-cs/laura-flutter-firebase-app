import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/customer.dart';

class CustomerStream {
  late final FirebaseFirestore _fireStoreDatabase;
  late final User? currentUser;
  late final CollectionReference? customers;

  CustomerStream() {
    _fireStoreDatabase = FirebaseFirestore.instance;
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var uid = currentUser!.uid;
      customers = _fireStoreDatabase.collection('users/$uid/customers');
    }
  }

  Stream<List<Customer>> getCustomerList() {
    if ((currentUser == null) || (customers == null)) {
      return const Stream.empty();
    } else {
      return customers!
          .orderBy(
            'createdAt',
            descending: false,
          )
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) =>
                  Customer.fromJson(doc.data() as Map<String, dynamic>, doc.id))
              .toList());
    }
  }
}

Future<void> addCustomers({
  required String name,
  required String phoneNumber,
}) async {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String uid = user.uid;
    CollectionReference? customers =
        FirebaseFirestore.instance.collection('users/$uid/customers');

    return customers
        .add({
          'name': name,
          'phoneNumber': phoneNumber,
          'createdAt': Timestamp.now(),
        })
        .then((val) => print('customer Added'))
        .catchError((error) => print("Failed to Add Customers: $error"));
  } else {
    return Future.value();
  }
}

Future<void> deleteCustomer(String hashcode) {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String uid = user.uid;
    CollectionReference? customers =
        FirebaseFirestore.instance.collection('users/$uid/customers');

    return customers
        .doc(hashcode.toString())
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  } else {
    return Future.value();
  }
}
