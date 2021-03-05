import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:nutri_calc/AddFormulaScreen.dart';
import 'package:nutri_calc/CalcForm.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'homescreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future LoadCSV() async {
    try {
      String data = await rootBundle.loadString('assets/data.csv');
      debugPrint(data);
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
    var input = new File('assets/data.csv');
    var inp = new File('../assets/data.csv');
    var k = new File('data.csv');
    var f = await input.open();
    /*final fields = await input
        .transform(utf8.decoder)
        .transform(new CsvToListConverter())
        .toList();*/
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert('data.csv');
    int a = 2;
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
                  onPressed: LoadCSV,
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
