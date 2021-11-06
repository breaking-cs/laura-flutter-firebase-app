import 'package:flutter/material.dart';
import "../widgets/custom_app_bar.dart";

class CustomersTxAdd extends StatefulWidget {
  static const routeName = "/customers_tx_add";

  CustomersTxAdd({Key? key}) : super(key: key);

  @override
  _CustomersTxAddState createState() => _CustomersTxAddState();
}

class _CustomersTxAddState extends State<CustomersTxAdd> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {'title': null, 'img': null};

  @override
  Widget build(BuildContext context) {
    void handleUserInput() async {
      if (_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Processing Data')));

        _formKey.currentState!.save();

        // await addCustomerTx(
        //   title: formData["title"],
        // );

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
                        return 'Please Enter Title';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.title),
                      labelText: 'Title',
                    ),
                    onSaved: (String? value) {
                      formData['title'] = value;
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
                      formData['image'] = value;
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
