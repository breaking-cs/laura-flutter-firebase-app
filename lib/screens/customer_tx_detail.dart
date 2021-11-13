import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../utils/date.dart';
import "../widgets/custom_app_bar.dart";
import '../widgets/gallery_item.dart';

class TxDetail extends StatelessWidget {
  static const routeName = '/tx_detail';

  const TxDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Transaction info =
        ModalRoute.of(context)?.settings.arguments as Transaction;

    return Scaffold(
      appBar: const CustomAppBar(title: "Customers"),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          Text("메모: ${info.memo}"),
          Text("금액: ${info.amount}"),
          Text("CreatedAt: ${formatDate(info.createdAt)}"),
          info.imgUrl == ""
              ? Text("no image")
              : Image.network(
                  info.imgUrl,
                  fit: BoxFit.cover,
                  width: 200,
                ),
        ]),
      ),
    );
  }
}
