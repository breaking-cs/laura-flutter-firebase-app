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
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color:Colors.black12),),
      ),
      child: ListTile(
        leading: const IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: null,
        ),
        title: Text(
          data.name,
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          data.phoneNumber,
          style: const TextStyle(fontSize: 15),
        ),
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
      ),
    );
  }
}
