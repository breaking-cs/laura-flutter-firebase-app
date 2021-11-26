import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/customer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

Future<void> deleteCustomer(String hashcode) async {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String uid = user.uid;
    CollectionReference? customers =
        FirebaseFirestore.instance.collection('users/$uid/customers');

    // tx도 하나하나 삭제하긴해야함
    FirebaseFirestore _fireStoreDatabase = FirebaseFirestore.instance;

    var result =
        await _fireStoreDatabase.collection('tx/$hashcode/purchase').get();

    result.docs.forEach((doc) async {
      // 이건 고객의 transaction의 이미지를 삭제하는것
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(doc['imgUrl'])
          .delete();

      // tr을 삭제
      doc.reference.delete();
    });

    return customers
        .doc(hashcode.toString())
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  } else {
    return Future.value();
  }
}
