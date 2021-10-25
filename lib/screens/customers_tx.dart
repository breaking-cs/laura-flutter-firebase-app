import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widgets/custom_app_bar.dart";
import '../providers/transactions.dart';
import "../models/customer.dart";

class CustomersTransaction extends StatelessWidget {
  static const routeName = '/customers_tx';
  const CustomersTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Customer;
    final name = routeArgs.name;
    final createdAt = routeArgs.createdAt;

    return Scaffold(
      appBar: CustomAppBar(title: "구매 내역"),
      body: Column(
        children: [
          Text("고객: ${name}"),
          Text("CreatedAt: ${createdAt}"),
          ElevatedButton(
            onPressed: () {
              context.read<Transactions>().addTransaction(
                    customerId: 123,
                    amount: 1000,
                    date: DateTime.now(),
                    imgUrl: 'https://picsum.photos/400',
                  );
            },
            child: const Text("Add Image"),
          )
        ],
      ),
    );
  }
}
