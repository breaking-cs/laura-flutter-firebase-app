import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "../widgets/custom_app_bar.dart";
import "../widgets/customer_list.dart";

class CustomerMain extends StatefulWidget {
  const CustomerMain({Key? key}) : super(key: key);

  @override
  State<CustomerMain> createState() => _CustomerMainState();
}

class _CustomerMainState extends State<CustomerMain> {
  String? uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference? customers =
        FirebaseFirestore.instance.collection('users/$uid/customers');

    Future<void> _addCustomers() {
      return customers
          .add({
            'name': 'Test야',
            'createdAt': Timestamp.now(),
          })
          .then((val) => print('customer Added'))
          .catchError((error) => print("Failed to Add Customers: $error"));
    }

    return Scaffold(
      appBar: const CustomAppBar(title: "Customers"),
      body: Column(
        children: [
          const Expanded(
            child: CustomerList(),
          ),
          ElevatedButton(
            onPressed: _addCustomers,
            child: const Text("손님 추가 test요"),
          ),
        ],
      ),
    );
  }
}
