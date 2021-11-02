import 'package:flutter/material.dart';
import "../widgets/custom_app_bar.dart";
import "../providers/customers.dart";

class CustomersAdd extends StatefulWidget {
  static const routeName = '/customers_add';

  const CustomersAdd({Key? key}) : super(key: key);

  @override
  State<CustomersAdd> createState() => _CustomersAddState();
}

class _CustomersAddState extends State<CustomersAdd> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {'name': null};

  @override
  Widget build(BuildContext context) {
    void handleUserInput() async {
      if (_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Processing Data')));

        _formKey.currentState!.save();

        await addCustomers(
          name: formData["name"],
        );

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(title: "Create Customers"),
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
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Name',
                    ),
                    onSaved: (String? value) {
                      formData['name'] = value;
                    },
                  )
                ],
              )),
          ElevatedButton(
            onPressed: handleUserInput,
            child: const Text("Add Customers"),
          ),
        ],
      ),
    );
  }
}
