import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:nutri_calc/AddFormulaScreen.dart';
import 'package:nutri_calc/CalcForm.dart';
import 'package:nutri_calc/DataHelper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

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
                        Fluttertoast.showToast(
                                msg: "Successfully imported CSV",
                                toastLength: Toast.LENGTH_SHORT)
                            .then((value) => Navigator.pushNamedAndRemoveUntil(
                                context, CalcForm.id, (route) => false));
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Error: Couldn't import CSV. Make sure it is valid.",
                            toastLength: Toast.LENGTH_SHORT);
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
                  ElevatedButton(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.import_export,
                            color: Colors.black87,
                          ),
                        ),
                        Text('Export CSV'),
                      ],
                    ),
                    onPressed: () async {
                      // if (await _pickFile()) {
                      //   Fluttertoast.showToast(
                      //       msg: "Successfully imported CSV",
                      //       toastLength: Toast.LENGTH_SHORT)
                      //       .then((value) => Navigator.pushNamedAndRemoveUntil(
                      //       context, CalcForm.id, (route) => false));
                      // } else {
                      //   Fluttertoast.showToast(
                      //       msg:
                      //       "Error: Couldn't import CSV. Make sure it is valid.",
                      //       toastLength: Toast.LENGTH_SHORT);
                      // }
                      Directory _documents = await getApplicationDocumentsDirectory();
                      File file = new File('${_documents.path}/data.csv');
                      // file.open(mode: FileMode.read);
                      OpenFile.open("${_documents.path}/data.csv");
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
    try {
      if (result != null) {
        File file = File(result.files.single.path);
        DataHelper dataHelper = new DataHelper();
        return await dataHelper.CreateNewCSV(file.path);
      }
    } catch (e) {}
    return false;
  }
}
