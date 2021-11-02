import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "./customer_card.dart";
import '../models/customer.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    final customers = Provider.of<List<Customer>>(context);

    return ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          return CustomerCard(index: index, data: customers[index]);
        });
  }
}
