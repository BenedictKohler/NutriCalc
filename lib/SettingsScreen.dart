import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:nutri_calc/AddFormulaScreen.dart';
import 'package:nutri_calc/DataHelper.dart';

class SettingsScreen extends StatefulWidget {
  static const id = 'settingsscreen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: Colors.red,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.black87,
                          ),
                        ),
                        Text('Add Drink'),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AddFormulaScreen.id);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.red; // Use the component's default.
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.table_rows_sharp,
                            color: Colors.black87,
                          ),
                        ),
                        Text('Import new CSV'),
                      ],
                    ),
                    onPressed: () async {
                      if (await _pickFile()) {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text("Import successful")));
                        print("Succesful import");
                      } else {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text(
                                "Couldn't import csv. Please try again!")));
                        print("Error with import");
                      }
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
          ],
        ));
  }

  Future<bool> _pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path);
      DataHelper dataHelper = new DataHelper();
      return await dataHelper.CreateNewCSV(file.path);
    }
    return false;
  }
}
