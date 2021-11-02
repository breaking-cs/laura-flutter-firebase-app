import 'package:flutter/material.dart';
import '../models/customer.dart';
import "../screens/customers_tx.dart";
import '../providers/customers.dart';

class CustomerCard extends StatelessWidget {
  final Customer data;
  final int index;
  const CustomerCard({Key? key, required this.index, required this.data})
      : super(key: key);

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
        icon: const Icon(Icons.delete),
        onPressed: () {
          deleteCustomer(data.id);
        },
      ),
      onTap: () => {
        Navigator.of(context).pushNamed(
          CustomersTransaction.routeName,
          arguments: index,
        )
      },
    );
  }
}
