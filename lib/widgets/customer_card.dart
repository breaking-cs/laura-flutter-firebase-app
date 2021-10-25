import 'package:flutter/material.dart';
import '../models/customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer data;
  const CustomerCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.person,
      ),
      title: Text(data.name),
      subtitle: Text(data.createdAt.toString()),
      trailing: const Icon(Icons.arrow_forward),
    );
  }
}
