import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "../widgets/custom_app_bar.dart";
import '../providers/transactions.dart';

class CustomersTxAdd extends StatefulWidget {
  static const routeName = "/customers_tx_add";

  const CustomersTxAdd({Key? key}) : super(key: key);

  @override
  _CustomersTxAddState createState() => _CustomersTxAddState();
}

class _CustomersTxAddState extends State<CustomersTxAdd> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {
    'amount': null,
    "memo": "",
    "imgUrl": ""
  };

  @override
  Widget build(BuildContext context) {
    final String customerId =
        ModalRoute.of(context)?.settings.arguments as String;

    void handleUserInput() async {
      if (_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Processing Data')));

        _formKey.currentState!.save();

        await addTransactions(
          customerId,
          memo: formData["memo"],
          amount: int.parse(formData["amount"]),
          imgUrl: formData["imgUrl"],
        );

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(title: "Create History"),
      body: Column(
        children: [
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Memo';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.note),
                      labelText: 'Memo',
                    ),
                    onSaved: (String? value) {
                      formData['memo'] = value;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Add Amount';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.money),
                      labelText: 'Money',
                    ),
                    onSaved: (String? value) {
                      formData['amount'] = value;
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Add Img';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.image),
                      labelText: 'Image',
                    ),
                    onSaved: (String? value) {
                      formData['imgUrl'] = value;
                    },
                  )
                ],
              )),
          ElevatedButton(
            onPressed: handleUserInput,
            child: const Text("Submit History"),
          ),
        ],
      ),
    );
  }
}
