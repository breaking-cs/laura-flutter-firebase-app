import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transactions.dart';
import "../models/customer.dart";
import "../models/transaction.dart" as tx;
import "../screens/customers_tx_add.dart";
import "../widgets/customer_tx_card.dart";

class CustomerTxList extends StatelessWidget {
  final Customer info;
  const CustomerTxList({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txs = Provider.of<List<tx.Transaction>?>(context);

    if (txs == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
        body: Column(
          children: [
              Expanded(
                child: ListView.builder(
                    itemCount: txs.length,
                    itemBuilder: (context, index) {
                      return TxCard(
                          index: index, customerId: info.id, data: txs[index]);
                    }),
              ),
            ],
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.of(context).pushNamed(
            CustomersTxAdd.routeName,
            arguments: info.id,
          );
        },
      ),
    );
  }
}
