import 'package:flutter/material.dart';
import '../widgets/gallery_item.dart';
import "../widgets/custom_app_bar.dart";
import '../providers/transactions.dart';
import "../utils/date.dart";

class Gallery extends StatefulWidget {
  Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<String>? transactions;

  @override
  void initState() {
    listTxImages().then((value) {
      setState(() {
        transactions = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (transactions == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (transactions!.length == 0) {
      return Scaffold(
        appBar: const CustomAppBar(title: "Gallery"),
        body: Text("사진을 추가해 주세요"),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(title: "Gallery"),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
          ),
          itemCount: transactions!.length,
          itemBuilder: (ctx, index) {
            return GalleryItem(
              imgUrl: transactions![index],
            );
          },
        ),
      ),
    );
  }
}
