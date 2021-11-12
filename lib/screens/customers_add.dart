import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
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
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.indigo),
                      hintText:'Enter your customer\'s name',
                      suffixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:BorderSide(
                            color: Colors.indigo,
                            width: 2.0),
                      ),
                    ),
                    onSaved: (String? value) {
                      formData['name'] = value;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Phone number',
                      labelStyle: TextStyle(color: Colors.indigo),
                      hintText:'Enter your customer\'s phone number',
                      suffixIcon: Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                                borderSide:BorderSide(
                                    color: Colors.indigo,
                                    width: 2.0),
                              ),
                    ),
                    onSaved: (String? value) {
                      //formData['name'] = value;
                      //TODO
                    },
                  ),
                ],
              )),
          SizedBox(height: 60),
          IconsButton(
            padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
            text: 'Submit Customer',
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
