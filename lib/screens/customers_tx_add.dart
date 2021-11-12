import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                        labelText: 'Memo',
                        labelStyle: TextStyle(color: Colors.indigo),
                        suffixIcon: Icon(
                          Icons.note,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:BorderSide(
                              color: Colors.indigo,
                              width: 2.0),
                        ),
                      ),
                      onSaved: (String? value) {
                        formData['memo'] = value;
                      },
                    ),
                    TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Add Amount';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Money',
                        labelStyle: TextStyle(color: Colors.indigo),
                        suffixIcon: Icon(
                          Icons.money,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:BorderSide(
                              color: Colors.indigo,
                              width: 2.0),
                        ),
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
                        labelText: 'Image',
                        labelStyle: TextStyle(color: Colors.indigo),
                        suffixIcon: Icon(
                          Icons.image,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:BorderSide(
                              color: Colors.indigo,
                              width: 2.0),
                        ),
                      ),
                      onSaved: (String? value) {
                        formData['imgUrl'] = value;
                      },
                    )
                  ],
                )),
            SizedBox(height: 40),
            IconsButton(
              padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
              text: 'Submit History',
              color: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20),
              onPressed: handleUserInput,
            ),
          ],
        ),
      ),
    );
  }
}
