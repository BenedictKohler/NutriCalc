import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nutri_calc/AddFormulaScreen.dart';
import 'package:nutri_calc/DataHelper.dart';
import 'package:nutri_calc/SettingsScreen.dart';
import 'package:nutri_calc/TempPdfCreator.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MaterialApp(
      title: "NutriCalc",
      home: CalcForm(),
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      )));
}

class CalcForm extends StatefulWidget {
  static const id = 'calcform';
  @override
  _CalcForm createState() => _CalcForm();
}

class _CalcForm extends State<CalcForm> {
// The Flutter key to point to the Form
  final GlobalKey<FormState> _key = GlobalKey();

  // Future<SharedPreferences> prefs = getSP();

  bool _isDataLoaded;
  HashMap<String, List<dynamic>> _csvData;
  DataHelper _dataHelper;

  String selectedDrink = "";
  int ageEntered;
  double quantityEntered;

  String selectedSex = "";

  String _fileName = "";

  var pdf = pw.Document();

  File pdfFile = null;

  static var _sexList = ["Male", "Female"];
  // static var drinks = ["Drink 1", "Drink 2", "Drink 3"];

  List<DropdownMenuItem<String>> _sexDropDownItems;
  List<DropdownMenuItem<String>> _drinkDropDownItems;

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
        _dataHelper.GetDataMap(csvList); // Convert list of lists to hashma
    _sexDropDownItems = getDropDownItems(_sexList);
    _drinkDropDownItems = getDropDownItems(_csvData.keys.toList());

    setState(() {
      _isDataLoaded = true; // data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.red.shade50.withOpacity(0.9),
        appBar: AppBar(
          title: new Text(
            "NutriCalc",
            style: TextStyle(
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
                            selectedDrink = selected;
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
                            ageEntered = int.parse(val);
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
                      leading:
                          const Icon(Icons.science_outlined, color: Colors.red),
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
                            selectedSex = selected;
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
                        if (_key.currentState.validate()) {
                          double mult =
                              quantityEntered / _csvData[selectedDrink][1];
                          List out = [];
                          try {
                            _csvData[selectedDrink].sublist(1).forEach((i) {
                              // print(i.runtimeType);
                              // print(i);
                              if (i == "N/A")
                                out.add("N/A");
                              else if (i * mult % 1 == 0)
                                out.add((i * mult).round());
                              else
                                out.add((i * mult).toStringAsFixed(2));
                            });
                          } catch (err) {
                            print(err);
                            print("Error in the input");
                          }
                          print(out);
                          createPDF(selectedDrink, out);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.red; // Use the component's default.
                          },
                        ),
                      ),
                    ),
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
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.red; // Use the component's default.
                          },
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
            Expanded(
                child: Container(
              child: SfPdfViewer.file(pdfFile),
            ))
          ],
        ));
  }

  void showAlert(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(content: Text(text)));
  }

  static List<DropdownMenuItem<String>> getDropDownItems(List<dynamic> drinks) {
    List<DropdownMenuItem<String>> items = new List<DropdownMenuItem<String>>();
    drinks.sort();
    for (var drink in drinks) {
      items.add(new DropdownMenuItem(
          child: new Text(
            drink,
            style: TextStyle(fontSize: 13),
          ),
          value: drink));
    }
    return items;
  }

  void navigateToSettings() {
    Navigator.pushNamed(context, SettingsScreen.id);
  }

  Future<bool> getPDF() async {
    _fileName = getFileName();
    final file = File("$_fileName.pdf");

    try {
      await file.writeAsBytes(await pdf.save());
    } catch (Exception) {
      return null;
    }
    pdfFile = file;
    return true;
  }

  String getFileName() {
    String x = DateTime.now().toString() + "_" + selectedDrink ?? " ";
    print(x);
    return x;
  }
}
