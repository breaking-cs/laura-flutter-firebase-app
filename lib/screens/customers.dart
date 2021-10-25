import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/transactions.dart';
import '../models/transaction.dart';
import "../widgets/custom_app_bar.dart";
import "../widgets/customer_list.dart";
import "../screens/customers_tx.dart";

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
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
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                CustomersTransaction.routeName,
                arguments: {'id': 1},
              );
            },
            child: const Text("구매 내역 임시로 연결한것"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<Transactions>().addTransaction(
                    customerId: 123,
                    amount: 1000,
                    date: DateTime.now(),
                    imgUrl: 'https://picsum.photos/400',
                  );
            },
            child: const Text("Provider Test"),
          )
        ],
      ),
    );
  }
}
