import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
  final picker = ImagePicker();
  File? _imageFile;
  final Map<String, dynamic> formData = {
    'amount': null,
    "memo": "",
  };

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile == null) {
        _imageFile = null;
      } else {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  void resetImage() {
    setState(() {
      _imageFile = null;
    });
  }

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
          imageFile: _imageFile,
        );

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: ListView(
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
                          borderSide:
                              BorderSide(color: Colors.indigo, width: 2.0),
                        ),
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
                        labelText: 'Money',
                        labelStyle: TextStyle(color: Colors.indigo),
                        suffixIcon: Icon(
                          Icons.money,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.indigo, width: 2.0),
                        ),
                      ),
                      onSaved: (String? value) {
                        formData['amount'] = value;
                      },
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  _imageFile != null
                      ? Stack(
                    children: [
                      ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        _imageFile!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),),
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: GestureDetector(
                          onTap: resetImage,
                          child: const Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      : DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          dashPattern: const [8, 4],
                          strokeWidth: 2,
                          color: Colors.indigo,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              alignment: Alignment.center,
                              height: 200,
                              width: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlatButton(
                                    child: const Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                                    onPressed: pickImage,
                                  ),
                                  const SizedBox(height: 20),
                                  const Text("이미지를 선택하세요",
                                    style: TextStyle(fontSize: 20,
                                        color: Colors.grey),
                                    textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            IconsButton(
              padding: const EdgeInsets.fromLTRB(80, 15, 80, 15),
              text: 'Submit History',
              color: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              textStyle: const TextStyle(color: Colors.white, fontSize: 20),
              onPressed: handleUserInput,
            ),
          ],
        ),
      ),
    );
  }
}
