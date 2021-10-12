import 'package:flutter/material.dart';
import "../components/custom_app_bar.dart";

class CustomersTransaction extends StatelessWidget {
  static const routeName = '/customers_tx';
  const CustomersTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, int>;
    final id = routeArgs['id'];

    return Scaffold(
      appBar: CustomAppBar(title: "구매 내역"),
      body: Text("Hello ${id.toString()}"),
    );
  }
}
