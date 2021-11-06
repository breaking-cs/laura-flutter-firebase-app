import 'package:flutter/material.dart';
import '../models/transaction.dart';
import "../screens/customers_tx.dart";
import '../providers/transactions.dart';

class TxCard extends StatelessWidget {
  final Transaction data;
  final int index;
  final String customerId;
  const TxCard(
      {Key? key,
      required this.index,
      required this.customerId,
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const IconButton(
        icon: Icon(Icons.person),
        onPressed: null,
      ),
      title: Text(data.createdAt.toString()),
      subtitle: Text(data.memo),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          deleteTransaction(customerId, data.id);
        },
      ),
      onTap: () => {
        // To Customer Transaciton 상세 화면
      },
    );
  }
}
