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
  final _drinkName = TextEditingController();
  final _volume = TextEditingController();
  final _v1 = TextEditingController();
  final _v2 = TextEditingController();
  final _v3 = TextEditingController();
  final _v4 = TextEditingController();
  final _v5 = TextEditingController();
  final _v6 = TextEditingController();
  final _v7 = TextEditingController();
  final _v8 = TextEditingController();
  final _v9 = TextEditingController();
  final _v10 = TextEditingController();
  final _v11 = TextEditingController();
  final _v12 = TextEditingController();
  final _v13 = TextEditingController();
  final _v14 = TextEditingController();
  final _v15 = TextEditingController();
  final _v16 = TextEditingController();
  final _v17 = TextEditingController();
  final _v18 = TextEditingController();
  final _v19 = TextEditingController();
  final _v20 = TextEditingController();
  final _v21 = TextEditingController();
  final _v22 = TextEditingController();
  final _v23 = TextEditingController();
  final _v24 = TextEditingController();
  final _v25 = TextEditingController();
  final _v26 = TextEditingController();
  final _v27 = TextEditingController();
  final _v28 = TextEditingController();
  final _v29 = TextEditingController();
  final _v30 = TextEditingController();
  final _v31 = TextEditingController();
  final _v32 = TextEditingController();
  final _v33 = TextEditingController();
  final _v34 = TextEditingController();
  final _v35 = TextEditingController();
  final _v36 = TextEditingController();
  final _v37 = TextEditingController();
  final _v38 = TextEditingController();
  final _v39 = TextEditingController();
  final _v40 = TextEditingController();

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Formula'),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyTextInputBox("* Required", 'Formula Name:', _drinkName),
                      MyTextInputBox("* Required", 'Volume (mL):', _volume),
                      MyTextInputBox("* Required", 'Calories:', _v1),
                      MyTextInputBox("* Required", 'Total fat (g):', _v2),
                      MyTextInputBox("* Required", 'Total carbs (g):', _v3),
                      MyTextInputBox("* Required", 'Sugars (g):', _v4),
                      MyTextInputBox("* Required", 'Dietary fiber (g):', _v5),
                      MyTextInputBox("* Required", 'Protein (g):', _v6),
                      MyTextInputBox("* Required", 'Cholestrol (mg):', _v7),
                      MyTextInputBox("* Required", 'water g(ml):', _v8),
                      MyTextInputBox("* Required", 'Vit A IU:', _v9),
                      MyTextInputBox("* Required", 'Vit C (mg):', _v10),
                      MyTextInputBox("* Required", 'Vit D IU:', _v11),
                      MyTextInputBox("* Required", 'Vit E IU:', _v12),
                      MyTextInputBox("* Required", 'Vit K (mcg):', _v13),
                      MyTextInputBox("* Required", 'folic acid (mcg):', _v14),
                      MyTextInputBox(
                          "* Required", 'Thiamin/Vit B1 (mg):', _v15),
                      MyTextInputBox(
                          "* Required", 'Riboflavin/Vit B2 (mg):', _v16),
                      MyTextInputBox("* Required", 'Vit B6 (mg):', _v17),
                      MyTextInputBox("* Required", 'Vit B12 (mcg):', _v18),
                      MyTextInputBox("* Required", 'niacin (mg):', _v19),
                      MyTextInputBox("* Required", 'biotin (mcg):', _v20),
                      MyTextInputBox(
                          "* Required", 'pantothenic acid (mg):', _v21),
                      MyTextInputBox("* Required", 'inositol(mg):', _v22),
                      MyTextInputBox("* Required", 'sodium (mg):', _v23),
                      MyTextInputBox("* Required", 'calcium (mg):', _v24),
                      MyTextInputBox("* Required", 'potassium (mg):', _v25),
                      MyTextInputBox("* Required", 'chloride (mg):', _v26),
                      MyTextInputBox("* Required", 'phosphorus (mg):', _v27),
                      MyTextInputBox("* Required", 'magnesium (mg):', _v28),
                      MyTextInputBox("* Required", 'iodine (mcg):', _v29),
                      MyTextInputBox("* Required", 'manganese (mg):', _v30),
                      MyTextInputBox("* Required", 'copper (mg):', _v31),
                      MyTextInputBox("* Required", 'zinc (mg):', _v32),
                      MyTextInputBox("* Required", 'iron (mg):', _v33),
                      MyTextInputBox("* Required", 'selenium (mcg):', _v34),
                      MyTextInputBox("* Required", 'chromium (mcg):', _v35),
                      MyTextInputBox("* Required", 'molybdenum (mcg):', _v36),
                      MyTextInputBox("* Required", 'choline (mg):', _v37),
                      MyTextInputBox("* Required", 'linoleic acid (mg):', _v38),
                      MyTextInputBox("* Required", 'Beta-carotene (mg):', _v39),
                      MyTextInputBox("* Required", 'Taurine (mg):', _v40),
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
                          // Make sure all inputs are valid
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          if (_drinkName.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Missing element of the form',
                                toastLength: Toast.LENGTH_SHORT);
                            return;
                          }
                          if (!ContainsDrink(_drinkName.text)) {
                            List<String> newDrink = [
                              _drinkName.text,
                              _volume.text,
                              _v1.text,
                              _v2.text,
                              _v3.text,
                              _v4.text,
                              _v5.text,
                              _v6.text,
                              _v7.text,
                              _v8.text,
                              _v9.text,
                              _v10.text,
                              _v11.text,
                              _v12.text,
                              _v13.text,
                              _v14.text,
                              _v15.text,
                              _v16.text,
                              _v17.text,
                              _v18.text,
                              _v19.text,
                              _v20.text,
                              _v21.text,
                              _v22.text,
                              _v23.text,
                              _v24.text,
                              _v25.text,
                              _v26.text,
                              _v27.text,
                              _v28.text,
                              _v29.text,
                              _v30.text,
                              _v31.text,
                              _v32.text,
                              _v33.text,
                              _v34.text,
                              _v35.text,
                              _v36.text,
                              _v37.text,
                              _v38.text,
                              _v39.text,
                              _v40.text
                            ];
                            widget.csvData
                                .putIfAbsent(_drinkName.text, () => newDrink);
                            DataHelper dataHelper = new DataHelper();
                            await dataHelper.WriteDataFromHMap(widget.csvData);
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    'Error: A drink with that name already exists',
                                toastLength: Toast.LENGTH_SHORT);
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
          ),
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
