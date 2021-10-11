import 'package:flutter/material.dart';

class TransactionDetail extends StatelessWidget {
  static const routeName = '/tx_detail';
  const TransactionDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, int>;
    final id = routeArgs['id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Laura"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Text("Hello ${id.toString()}"),
    );
  }
}
