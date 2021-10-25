import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widgets/custom_app_bar.dart";
import '../providers/transactions.dart';

class CustomersTransaction extends StatelessWidget {
  static const routeName = '/customers_tx';
  const CustomersTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "구매 내역"),
      body: Column(
        children: [
          Text("Hello - 여기서 고객정보랑 구매내역 쭉 보여줄 예정"),
          ElevatedButton(
            onPressed: () {
              context.read<Transactions>().addTransaction(
                    customerId: 123,
                    amount: 1000,
                    date: DateTime.now(),
                    imgUrl: 'https://picsum.photos/400',
                  );
            },
            child: const Text("Add Image"),
          )
        ],
      ),
    );
  }
}
