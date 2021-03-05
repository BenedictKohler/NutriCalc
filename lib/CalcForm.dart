import 'dart:collection';

import 'package:flutter/material.dart';

void main() {

  runApp(
      MaterialApp(
        title: "NutriCalc",
        home: CalcForm(),
      )
  );
}


// This is a stateful widget. Don't worry about how it or
// the setState() calls work until
// Chapter 9. For now, just focus on the Form itself.
class CalcForm extends StatefulWidget {
  static const id = 'calcform';
  @override
  _CalcForm createState() => _CalcForm();
}

class _CalcForm extends State<CalcForm> {
// A Map (aka. hash) to hold the data from the Form.
//   final Map<String, dynamic> _searchForm = <String, dynamic>{
//     'searchTerm': "",
//     'searchType': SearchType.web,
//     'safeSearchOn': true,
//   };
// The Flutter key to point to the Form
  final GlobalKey<FormState> _key = GlobalKey();
  String selectedDrink = "";
  int ageEntered;
  double quantityEntered;


  // HashMap<String, List<double>> map;

  static var drinks = [
    "Drink 1",
    "Drink 2",
    "Drink 3"
  ];

  List<DropdownMenuItem<String>> dropDownItems = getDropDownItems(drinks);

  @override
  Widget build(BuildContext context) {
    return Material(child:
    Form(

      key: _key,
      // Make autovalidate true to validate on every keystroke. In
      // this case we only want to validate on submit.
      autovalidateMode: AutovalidateMode.always,
      child: Container(

        child: ListView(
          children: <Widget>[
            DropdownButtonFormField<String>(
                items: dropDownItems,
                hint: new Text("Select drink"),
                onChanged: (String selected) {
                  setState( () {
                    selectedDrink = selected;
                  });
                },


            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Enter Age (yrs)"
              ),
              keyboardType: TextInputType.number,
              onChanged: (String val) {
                setState(() {
                  ageEntered = int.parse(val);
                });
              },

              onSaved: (String val) { },

              validator: (String val) {

                return null;
              },
            ),
            TextFormField(
              // initialValue: "Enter quantity",
              decoration: InputDecoration(
                labelText: "Enter Quantity (mL)"
              ),
              onChanged: (String val) {
                setState(() {
                  quantityEntered = double.parse(val);
                });
              },
              keyboardType: TextInputType.number,

              onSaved: (String val) { },

              validator: (String val) {

                return null;
              },
            ),

            // Wrapping the Checkbox in a FormField so we can have an
            // onSaved and a validator

            // This is the 'Submit' button
            RaisedButton(
                child: const Text('Submit'),
                onPressed: () {
                  // Navigator.push(context,MaterialPageRoute(builder: (context) => _ProperFormState())); // ?
                  // If every field passes validation, let them through.
                  // Remember, this calls the validator on all fields in
                  // the form.

                  // Similarly this calls onSaved() for all fields

                  // You'd save the data to a database or whatever here
                  if (_key.currentState.validate())
                    print('Successfully saved the state.');
                }

            )
          ],
        ),
      ),
    ));
  }

  // void _dropDownChanged(SearchType val) {
  //   setState(() => _searchForm['searchType'] = val);
  // }

  void showAlert(BuildContext context, String text){
    showDialog(context: context, builder: (context) => AlertDialog(
        content: Text(text)
    ));
  }

  static List<DropdownMenuItem<String>> getDropDownItems(dynamic drinks) {
    List<DropdownMenuItem<String>> items = new List<DropdownMenuItem<String>>();
    for (var drink in drinks) {
      debugPrint(drink);
      items.add(new DropdownMenuItem(child: new Text(drink), value: drink));
    }
    return items;
  }

}