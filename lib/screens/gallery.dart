import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/gallery_item.dart';
import "../widgets/custom_app_bar.dart";
import '../providers/transactions.dart';
import "../utils/date.dart";

class Gallery extends StatelessWidget {
  Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final transactions = context.watch<Transactions>().items;

    return Text("hello");
    // Scaffold(
    //   appBar: const CustomAppBar(title: "Gallery"),
    //   body: GridView.builder(
    //     padding: const EdgeInsets.all(10),
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       crossAxisSpacing: 10,
    //       mainAxisSpacing: 5,
    //     ),
    //     itemCount: transactions.length,
    //     itemBuilder: (ctx, index) {
    //       return GalleryItem(
    //         title:
    //             "id: ${transactions[index].id} , ${formatDate(transactions[index].date)}",
    //         imgUrl: transactions[index].imgUrl,
    //       );
    //     },
    //   ),
    // );
  }
}
