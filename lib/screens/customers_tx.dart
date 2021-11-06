import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widgets/custom_app_bar.dart";
import '../widgets/customer_detailed_info.dart';
import '../widgets/customer_tx_list.dart';
import "../models/customer.dart";
import "../models/transaction.dart";
import '../providers/transactions.dart';

class CustomersTransaction extends StatelessWidget {
  static const routeName = '/customers_tx';
  const CustomersTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Customer> customerList = Provider.of<List<Customer>>(context);
    final int index = ModalRoute.of(context)?.settings.arguments as int;
    final Customer customer = customerList[index];

    // customer.id 이걸로 tx/customer.id/purchase 밑에거 가져와서 읽고 보여주고 하면됨
    // tx/고객 document id/purchase 밑에 쭈욱다 transaction이다.
    return StreamProvider<List<Transaction>?>(
      create: (_) =>
          TransactionStream(customerId: customer.id).getTransationList(),
      initialData: null,
      child: Scaffold(
        appBar: CustomAppBar(title: "구매 내역"),
        body: Column(
          children: [
            CustomerDetailedInfo(info: customer),
            Expanded(
              child: CustomerTxList(info: customer),
            ),
          ],
        ),
      ),
    );
  }
}
