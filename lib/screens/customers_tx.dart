import 'package:flutter/cupertino.dart';
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text('고객 정보',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                child: Row(
                  children:[
                    SizedBox(
                      child: CustomerDetailedInfo(info: customer),
                      width: 200,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:[
                          const Text('10 회',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 1,
                            width: double.maxFinite,
                            color: Colors.white54,
                          ),
                          const SizedBox(height: 10),
                          const Text('10,000 원',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
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