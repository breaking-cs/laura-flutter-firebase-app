import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transactions.dart';
import "../models/customer.dart";
import "../models/transaction.dart" as tx;
import "../screens/customers_tx_add.dart";
import "../widgets/customer_tx_card.dart";

class CustomerTxList extends StatelessWidget {
  final Customer info;
  const CustomerTxList({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txs = Provider.of<List<tx.Transaction>?>(context);

    if (txs == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                fit: StackFit.passthrough,
                overflow: Overflow.visible,
                children: [
                  Container(),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadiusDirectional.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children:[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 30,),
                                const Text("구매 히스토리",
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle, size: 30),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      CustomersTxAdd.routeName,
                                      arguments: info.id,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: GridView.builder(
                                  padding: const EdgeInsets.all(10),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 1.4,
                                  ),
                                  itemCount: txs.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: TxCard(
                                          index: index, customerId: info.id, data: txs[index]
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadiusDirectional.circular(20),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 15.0,
                                            spreadRadius: 1.0,
                                            offset: Offset(5, 5),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
