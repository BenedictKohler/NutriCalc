import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:nutri_calc/AddFormulaScreen.dart';
import 'package:nutri_calc/CalcForm.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:nutri_calc/DataHelper.dart';
import 'dart:collection';

class HomeScreen extends StatefulWidget {
  static const id = 'homescreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDataLoaded;
  HashMap<String, List<dynamic>> _csvData;
  DataHelper _dataHelper;

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
    setState(() {
      _isDataLoaded = true; // data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Load CSV"),
                  onPressed: loadCSV,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    child: Text('Add New Formula'),
                    onPressed: () =>
                        Navigator.pushNamed(context, AddFormulaScreen.id),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    child: Text('Calculate'),
                    onPressed: () =>
                        Navigator.pushNamed(context, CalcForm.id),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
