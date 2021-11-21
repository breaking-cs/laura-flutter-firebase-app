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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Created at: ${formatDate(info.createdAt)}",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text("Memo: ${info.memo}",
                    style: const TextStyle(color: Colors.black),),
                  const SizedBox(height: 10),
                  Text("Price: ₩  ${info.amount}",
                    style: const TextStyle(color: Colors.black),),
                  const SizedBox(height: 50),
                ],
              ),
              info.imgUrl == ""
                  ? const Text("no image")
                  : Image.network(
                      info.imgUrl,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
            ],
        ),
      ),
    );
  }
}
