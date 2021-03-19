import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:nutri_calc/DataHelper.dart';

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
      body: Center(
        child: !_isDataLoaded
            ? CircularProgressIndicator()
            : Text("Data has been loaded: " + _csvData.length.toString()),
      ),
    );
  }
}
