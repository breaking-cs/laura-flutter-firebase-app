import 'package:flutter/material.dart';
import '../models/customer.dart';
import "../screens/customers_tx.dart";

class CustomerCard extends StatelessWidget {
  final Customer data;
  const CustomerCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const IconButton(
        icon: Icon(Icons.person),
        onPressed: null,
      ),
      title: Text(data.name),
      subtitle: Text(data.createdAt.toString()),
      trailing: IconButton(
        icon: const Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.of(context).pushNamed(
            CustomersTransaction.routeName,
            arguments: data,
          );
        },
      ),
    );
  }
}
