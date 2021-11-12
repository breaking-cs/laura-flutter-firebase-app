import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final Map<String, dynamic> formData = {
    'name': '',
    'phoneNumber': '',
  };

  @override
  Widget build(BuildContext context) {
    void handleUserInput() async {
      if (_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Processing Data')));

        _formKey.currentState!.save();

        await addCustomers(
          name: formData["name"],
          phoneNumber: formData["phoneNumber"],
        );

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      }
    }

    TextEditingValue convert(
      TextEditingValue oldValue,
      TextEditingValue newValue,
    ) {
      String newText = newValue.text;

      if (newText.length > 13) {
        newText = oldValue.text;
      } else {
        // TODO 커서를 위치를 옮기면 깨짐. 임시 방편으로 넣어둔거라.
        if (oldValue.text.length < newValue.text.length) {
          // 입력중
          // 012 (3) 4567 (8) 9(10)(11)(12)
          if (newValue.text.length == 3 || newValue.text.length == 8) {
            newText += "-";
          }
        } else {
          // 지우는 중
          if (newValue.text.length == 4 || newValue.text.length == 9) {
            newText = newText.substring(0, newText.length - 1);
          }
        }
      }

      setState(() {
        formData["phoneNumber"] = newText;
      });

      return TextEditingValue(
          text: newText,
          selection: TextSelection(
            baseOffset: newText.length,
            extentOffset: newText.length,
          ));
    }

    return Scaffold(
      appBar: const CustomAppBar(title: "Create Customer"),
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
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      TextInputFormatter.withFunction(
                          (oldValue, newValue) => convert(oldValue, newValue))
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter PhoneNumber';
                      }

                      RegExp regExp = RegExp(r'^010-([0-9]{4})-([0-9]{4})$');

                      if (value.length != 13 || !regExp.hasMatch(value)) {
                        return 'Please Enter valid phoneNumber. Ex) 010-1234-5677';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      labelText: 'Phone Number',
                      hintText: "010-1234-5677",
                    ),
                    onSaved: (String? value) {
                      formData['phoneNumber'] = value;
                    },
                  ),
                ],
              )),
          ElevatedButton(
            onPressed: handleUserInput,
            child: const Text("Submit Customer"),
          ),
        ],
      ),
    );
  }
}
