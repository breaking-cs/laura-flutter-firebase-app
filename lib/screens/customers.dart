import 'package:flutter/material.dart';
import "../components/custom_app_bar.dart";
import "../screens/customers_tx.dart";

class Customers extends StatelessWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Customers"),
      body: Column(
        children: [
          Text("Welcome"),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  CustomersTransaction.routeName,
                  arguments: {'id': 1},
                );
              },
              child: Text("구매 내역 임시로 연결한것"))
        ],
      ),
    );
  }
}
