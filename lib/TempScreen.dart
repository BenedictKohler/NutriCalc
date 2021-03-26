import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:nutri_calc/AddFormulaScreen.dart';
import 'package:nutri_calc/DataHelper.dart';

class TempScreen extends StatefulWidget {
  static const id = 'tempscreen';
  @override
  _TempScreenState createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  bool _isDataLoaded;
  HashMap<String, List<dynamic>> _csvData;
  DataHelper _dataHelper;

  final GlobalKey<FormState> _key = GlobalKey();
  String _selectedDrink = "";
  int _ageEntered = 0;
  double _quantityEntered = 0;

  String _selectedSex = "";

  List<DropdownMenuItem<String>> _sexDropDownItems;
  List<DropdownMenuItem<String>> _drinkDropDownItems;

  List<String> _sexList = ["Male", "Female"];

  List<DropdownMenuItem<String>> getGenderDropDown(List<String> genders) {
    List<DropdownMenuItem<String>> items = new List<DropdownMenuItem<String>>();
    for (String gender in genders) {
      items.add(new DropdownMenuItem(child: new Text(gender), value: gender));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDrinkDropDown() {
    List<DropdownMenuItem<String>> items = new List<DropdownMenuItem<String>>();
    for (String drink in _csvData.keys) {
      items.add(new DropdownMenuItem(child: new Text(drink), value: drink));
    }
    return items;
  }

  @override
  Future<void> initState() {
    super.initState();
    _isDataLoaded = false;
    _dataHelper = new DataHelper();
    loadCSV();
  }

  void loadCSV() async {
    List<List<dynamic>> csvList =
        await _dataHelper.GetDataList(); // Get list of lists of csv data
    _csvData =
        _dataHelper.GetDataMap(csvList); // Convert list of lists to hashmap
    _sexDropDownItems = getGenderDropDown(_sexList);
    _drinkDropDownItems = getDrinkDropDown();
    setState(() {
      _isDataLoaded = true; // data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: !_isDataLoaded
          ? Center(child: CircularProgressIndicator())
          : PageView(
              children: <Widget>[
                Form(
                  key: _key,
                  autovalidateMode: AutovalidateMode.always,
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          // tileColor: Colors.red.withOpacity((0.1)),
                          leading: const Icon(Icons.local_drink_rounded,
                              color: Colors.red),
                          title: new DropdownButtonFormField<String>(
                            items: _drinkDropDownItems,
                            hint: new Text(
                              "Select Drink",
                              style: TextStyle(
                                fontFamily: "Josefin Sans",
                                color: Colors.red,
                              ),
                            ),
                            onChanged: (String selected) {
                              setState(() {
                                _selectedDrink = selected;
                              });
                            },
                          ),
                        ),
                        const Divider(height: 15.0, color: Colors.white),
                        const Divider(
                          indent: 80.0,
                          endIndent: 80.0,
                          thickness: 1.0,
                          height: 10.0,
                          color: Colors.black,
                        ),
                        ListTile(
                          leading: const Icon(Icons.calendar_today_sharp,
                              color: Colors.red),
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
                                _ageEntered = int.parse(val);
                              });
                            },
                            onSaved: (String val) {},
                            validator: (String val) {
                              return null;
                            },
                          ),
                        ),
                        const Divider(
                          height: 15.0,
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
                          leading: const Icon(Icons.science_outlined,
                              color: Colors.red),
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
                                _quantityEntered = double.parse(val);
                              });
                            },
                            keyboardType: TextInputType.number,

                            onSaved: (String val) {},

                            validator: (String val) {
                              return null;
                            },
                          ),
                        ),
                        const Divider(
                          height: 15.0,
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
                          leading: const Icon(Icons.person_outline_outlined,
                              color: Colors.red),
                          title: new DropdownButtonFormField<String>(
                            items: _sexDropDownItems,
                            hint: new Text(
                              "Select Sex",
                              style: TextStyle(
                                fontFamily: "Josefin Sans",
                                color: Colors.red,
                              ),
                            ),
                            onChanged: (String selected) {
                              setState(() {
                                _selectedSex = selected;
                              });
                            },
                          ),
                        ),
                        const Divider(
                          height: 15.0,
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
                            child: const Text(
                              'Calculate',
                              style: TextStyle(
                                fontFamily: "Josefin Sans",
                              ),
                            ),
                            onPressed: () {
                              if (_key.currentState.validate())
                                print('Calculating...');
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          child: Text(
                            "Add new Formula",
                            style: TextStyle(
                              fontFamily: "Josefin Sans",
                            ),
                          ),
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddFormulaScreen(
                                        csvData: _csvData,
                                      ))),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
