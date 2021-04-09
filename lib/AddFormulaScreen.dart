import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:nutri_calc/CalcForm.dart';
import 'package:nutri_calc/DataHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFormulaScreen extends StatefulWidget {
  static const id = 'addformulascreen';
  final HashMap<String, List<dynamic>> csvData;

  const AddFormulaScreen({Key key, this.csvData}) : super(key: key);

  @override
  _AddFormulaScreenState createState() => _AddFormulaScreenState();
}

class _AddFormulaScreenState extends State<AddFormulaScreen> {
  final _drink = TextEditingController();
  final _protein = TextEditingController();
  final _fat = TextEditingController();
  final _salt = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Makes sure that the user is not trying to overwrite an existing drink
  bool ContainsDrink(String drink) {
    for (String d in widget.csvData.keys) {
      if (drink == d) return true;
    }
    return false;
  }

  @override
  void initState() {
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Formula'),
          backgroundColor: Colors.red,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyTextInputBox('Your formula must have a name',
                        'Enter formula name', _drink),
                    MyTextInputBox('Protein must have a value',
                        'Enter protein amount', _protein),
                    MyTextInputBox(
                        'Fat must have a value', 'Enter fat amount', _fat),
                    MyTextInputBox(
                        'Salt must have a value', 'Enter salt content', _salt),
                    ElevatedButton(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.save,
                              color: Colors.black87,
                            ),
                          ),
                          Text('Save Formula'),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.red; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: () async {
                        if (_drink.text == null ||
                            _protein.text == null ||
                            _fat.text == null ||
                            _salt.text == null ||
                            _drink.text == "" ||
                            _protein.text == "" ||
                            _fat.text == "" ||
                            _salt.text == "") {
                          Fluttertoast.showToast(
                              msg: 'Missing element of the form',
                              toastLength: Toast.LENGTH_SHORT);
                          return;
                        }
                        if (!ContainsDrink(_drink.text)) {
                          List<String> newDrink = [
                            _drink.text,
                            _protein.text,
                            _fat.text,
                            _salt.text
                          ];
                          widget.csvData
                              .putIfAbsent(_drink.text, () => newDrink);
                          DataHelper dataHelper = new DataHelper();
                          await dataHelper.WriteDataFromHMap(widget.csvData);
                          print("Success");
                        } else {
                          print("Already has drink");
                        }
                        Navigator.pushNamedAndRemoveUntil(
                            context, CalcForm.id, (route) => false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

Widget MyTextInputBox(
    String validatorVal, String hintText, TextEditingController controller) {
  return Padding(
    padding: EdgeInsets.all(5.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.lightBlueAccent,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      obscureText: false,
      validator: (value) {
        if (value.isEmpty) {
          return validatorVal;
        }
        return null;
      },
    ),
  );
}
