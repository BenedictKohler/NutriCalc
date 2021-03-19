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
            primarySwatch: Colors.red,
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

  String selectedSex = "";

  static var sexList = [
    "Male",
    "Female"
  ];
  static var drinks = [
    "Drink 1",
    "Drink 2",
    "Drink 3"
  ];

  List<DropdownMenuItem<String>> sexDropDownItems = getDropDownItems(sexList);
  List<DropdownMenuItem<String>> dropDownItems = getDropDownItems(drinks);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red.shade50.withOpacity(0.9),
      appBar: AppBar(
        title: new Text("NutriCalc", style: TextStyle(
          fontFamily: "Josefin Sans",
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
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
                  ListTile(
                    // tileColor: Colors.red.withOpacity((0.1)),
                    leading: const Icon(Icons.local_drink_rounded, color: Colors.red),
                    title: new DropdownButtonFormField<String>(
                      items: dropDownItems,
                      hint: new Text("Select Drink", style: TextStyle(
                        fontFamily: "Josefin Sans",
                        color: Colors.red,
                      ), ),
                      onChanged: (String selected) {
                        setState( () {
                          selectedDrink = selected;
                        });
                      },
                    ),
                  ),
                  const Divider(
                    height : 15.0,
                    color: Colors.white
                  ),
                  const Divider(
                    indent: 80.0,
                    endIndent: 80.0,
                    thickness: 1.0,
                    height: 10.0,
                    color: Colors.black,
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today_sharp, color: Colors.red),
                    title: new TextFormField(
                      decoration: InputDecoration(
                          labelText: "Enter Age (yrs)",
                        labelStyle: TextStyle(
                          fontFamily: "Josefin Sans",
                          color: Colors.red,
                        ),
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
                  ),
                  const Divider(
                    height : 15.0,
                    color : Colors.white,
                  ),
                  const Divider(
                    indent: 80.0,
                    endIndent: 80.0,
                    thickness: 1.0,
                    height: 10.0,
                    color: Colors.black,
                  ),
                  ListTile(
                    leading: const Icon(Icons.science_outlined, color: Colors.red),
                    title: new TextFormField(
                      // initialValue: "Enter quantity",
                      decoration: InputDecoration(
                          labelText: "Enter Quantity (mL)",
                          labelStyle: TextStyle(
                        fontFamily: "Josefin Sans",
                            color: Colors.red,
                      ),
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
                  ),
                  const Divider(
                    height : 15.0,
                    color: Colors.white,
                  ),
                  const Divider(
                    indent: 80.0,
                    endIndent: 80.0,
                    thickness: 1.0,
                    height: 10.0,
                    color: Colors.black,
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_outline_outlined, color: Colors.red),
                    title: new DropdownButtonFormField<String>(
                      items: sexDropDownItems,
                      hint: new Text("Select Sex", style: TextStyle(
                        fontFamily: "Josefin Sans",
                        color: Colors.red,
                      ),),
                      onChanged: (String selected) {
                        setState( () {
                          selectedSex = selected;
                        });
                      },
                    ),
                  ),
                  const Divider(
                    height : 15.0,
                    color: Colors.white,
                  ),
                  const Divider(
                    indent: 80.0,
                    endIndent: 80.0,
                    thickness: 1.0,
                    height: 10.0,
                    color: Colors.black,
                  ),
                  ElevatedButton(
                    child: const Text('Calculate', style: TextStyle(
                      fontFamily: "Josefin Sans",
                    ),),
                    onPressed: () {
                      if (_key.currentState.validate())
                        print('Calculating...');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return Colors.red; // Use the component's default.
                        },
                      ),

                    ),

                  ),
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