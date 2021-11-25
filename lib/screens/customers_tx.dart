import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/customer_detailed_info.dart';
import '../widgets/customer_tx_list.dart';
import '../widgets/customer_main_info.dart';
import "../models/customer.dart";
import "../models/transaction.dart";
import '../providers/transactions.dart';

class CustomersTransaction extends StatefulWidget {
  static const routeName = '/customers_tx';
  const CustomersTransaction({Key? key}) : super(key: key);

  @override
  State<CustomersTransaction> createState() => _CustomersTransactionState();
}

class _CustomersTransactionState extends State<CustomersTransaction> {
  int _txLength = 0;

  void lengthSetter(int len) {
    setState(() {
      _txLength = len;
    });
  }

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
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            '고객 정보',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      child: CustomerDetailedInfo(info: customer),
                      width: 200,
                    ),
                    Container(
                      child: const CustomerMainInfo(),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadiusDirectional.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      width: 160,
                      height: 120,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                width: double.infinity,
                height: 150,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: CustomerTxList(info: customer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
