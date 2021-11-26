import 'package:app/utils/date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../providers/transactions.dart';

class TxCard extends StatelessWidget {
  final Transaction data;
  final int index;
  final String customerId;
  const TxCard(
      {Key? key,
        required this.index,
        required this.customerId,
        required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formatDate(data.createdAt),
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        data.imgUrl == ""
                            ? const Text("no image")
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            data.imgUrl,
                            fit: BoxFit.cover,
                            width: 72,
                            height: 72,
                          ),
                        ),
                        Text(data.memo,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text("₩ ${data.amount}",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 5.0,
          top: 5.0,
          child: GestureDetector(
            onTap: (){
              deleteTransaction(customerId, data.id, data.imgUrl);
            },
            child: const Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 12.0,
                backgroundColor: Colors.transparent,
                child: Icon(Icons.close, color: Colors.red),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
