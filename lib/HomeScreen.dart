import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:nutri_calc/AddFormulaScreen.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

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
    String csv = "";
    try {
      String data = await rootBundle.loadString('assets/data.csv');
      List<List<dynamic>> rowsAsListOfValues =
          const CsvToListConverter().convert(data);
      debugPrint(data);
      rowsAsListOfValues[0].add('Random Value');
      csv = const ListToCsvConverter().convert(rowsAsListOfValues);
    } catch (e) {
      print('Error: $e');
      rethrow;
    }

    Directory documents = await getApplicationDocumentsDirectory();
    debugPrint(documents.path);
    try {
      File file = File('${documents.path}/data.csv');
      await file.writeAsString(csv);
    } catch (e) {
      debugPrint('Error: $e');
    }
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
              ],
            ),
          ],
        ));
  }
}
