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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Created at: ${formatDate(info.createdAt)}",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text("Memo: ${info.memo}",
                    style: TextStyle(color: Colors.black),),
                  SizedBox(height: 10),
                  Text("Price: ₩  ${info.amount}",
                    style: TextStyle(color: Colors.black),),
                  SizedBox(height: 50),
                ],
              ),
              info.imgUrl == ""
                  ? Text("no image")
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                      info.imgUrl,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
              ),
            ],
        ),
      ),
    );
  }
}
