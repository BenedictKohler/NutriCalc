import 'dart:collection';

import 'package:flutter/material.dart';
import 'SettingsScreen.dart';

void main() {

  runApp(
      MaterialApp(
        title: "NutriCalc",
        home: CalcForm(),
          theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.dark,
            primaryColor: Colors.lightBlue[800],
            accentColor: Colors.cyan[600],

            fontFamily: 'Georgia',

            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
          )
      )
  );
}


class CalcForm extends StatefulWidget {
  static const id = 'calcform';
  @override
  _CalcForm createState() => _CalcForm();
}

class _CalcForm extends State<CalcForm> {

// The Flutter key to point to the Form
  final GlobalKey<FormState> _key = GlobalKey();
  String selectedDrink = "";
  int ageEntered;
  double quantityEntered;
  String _appBarText = "NutriCalc";

  static var drinks = [
    "Drink 1",
    "Drink 2",
    "Drink 3"
  ];

  List<DropdownMenuItem<String>> dropDownItems = getDropDownItems(drinks);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(_appBarText),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              navigateToSettings();
            },
          ),
        ],
      ),
      body: PageView(
        children: <Widget>[
          Form(
            key: _key,
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
                  RaisedButton(
                    child: const Text('Calculate'),
                    onPressed: () {
                      if (_key.currentState.validate())
                        print('Calculating...');
                    }

                  )
                ],
              ),
            ),
          )
        ],
      )
    );
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

  void navigateToSettings(){
    Navigator.pushNamed(context, SettingsScreen.id);
  }

}