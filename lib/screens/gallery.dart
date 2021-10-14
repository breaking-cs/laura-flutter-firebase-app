import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/gallery_item.dart';
import "../components/custom_app_bar.dart";
import '../providers/transactions.dart';

class Gallery extends StatelessWidget {
  Gallery({Key? key}) : super(key: key);

  String formatDate(DateTime tx) {
    return "${tx.year.toString()}년 ${tx.month.toString()}월 ${tx.day.toString()}일";
  }

  @override
  Widget build(BuildContext context) {
    final transactions = context.watch<Transactions>().items;

    return Scaffold(
      appBar: const CustomAppBar(title: "Gallery"),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
        ),
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return GalleryItem(
            title:
                "id: ${transactions[index].id} , ${formatDate(transactions[index].date)}",
            imgUrl: transactions[index].imgUrl,
          );
        },
      ),
    );
  }
}
