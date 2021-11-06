import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widgets/custom_app_bar.dart";
import "../widgets/customer_info.dart";
import "../widgets/customer_history.dart";
import "../models/customer.dart";

class CustomersTransaction extends StatelessWidget {
  static const routeName = '/customers_tx';
  const CustomersTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Customer> customerList = Provider.of<List<Customer>>(context);
    final int index = ModalRoute.of(context)?.settings.arguments as int;
    final Customer customer = customerList[index];

    return Scaffold(
      appBar: CustomAppBar(title: "구매 내역"),
      body: Column(
        children: [
          CustomerInfo(info: customer),
          CustomerHistory(info: customer),
        ],
      ),
    );
  }
}
