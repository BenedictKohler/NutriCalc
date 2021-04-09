import 'dart:collection';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// Errors: Currently removes the top row which could be an issue when trying to write data from hashmap back

class DataHelper {
  Directory _documents;

  /* Writes the data to file on users phone if not already there
     and then gets text data into list and returns it */
  Future<List<List<dynamic>>> GetDataList() async {
    String textData = "";
    _documents = await getApplicationDocumentsDirectory();
    File file = new File('${_documents.path}/data.csv');
    file.open(mode: FileMode.append);
    if (!await IsPopulated()) {
      String data = await rootBundle.loadString('assets/data.csv');
      try {
        file = await file.writeAsString(data, flush: true);
      } catch (e) {}
    }

    try {
      textData = file.readAsStringSync();
    } catch (e) {}

    List<List<dynamic>> csvData = const CsvToListConverter().convert(textData);
    return csvData;
  }

  // Checks to see if file on users phone has got data already
  Future<bool> IsPopulated() async {
    //return Future.delayed(Duration(milliseconds: 20)).then((value) => false);
    if (_documents == null)
      _documents = await getApplicationDocumentsDirectory();
    File file = new File('${_documents.path}/data.csv');
    try {
      if (file.existsSync()) return true;
    } catch (e) {}
    return false;
  }

  // Converts a list of lists to a map where the key is the formula name and values are a list of nutrients
  HashMap<String, List<dynamic>> GetDataMap(List<List<dynamic>> data) {
    HashMap<String, List<dynamic>> hashMap =
        new HashMap<String, List<dynamic>>();
    for (int i = 1; i < data.length; i++) {
      hashMap.putIfAbsent(
          data.elementAt(i).elementAt(0), () => data.elementAt(i));
    }
    return hashMap;
  }

  // Write csv data back to a file
  Future WriteDataFromList(List<List<dynamic>> data) async {
    if (_documents == null) {
      _documents = await getApplicationDocumentsDirectory();
    }
    File file = new File('${_documents.path}/data.csv');
    data.insert(0, ["Drink", "Protein", "Fat", "Salt"]);
    String csvString = const ListToCsvConverter().convert(data);
    await file.writeAsString(csvString);
  }

  // Write csv data back to a file
  Future WriteDataFromHMap(HashMap<String, List<dynamic>> data) async {
    if (_documents == null) {
      _documents = await getApplicationDocumentsDirectory();
    }
    File file = new File('${_documents.path}/data.csv');
    List<List<dynamic>> tempList = new List<List<dynamic>>();
    tempList.add(["Drink", "Protein", "Fat", "Salt"]);
    for (List<dynamic> vals in data.values) {
      tempList.add(vals);
    }
    String csvString = const ListToCsvConverter().convert(tempList);
    await file.writeAsString(csvString);
  }
}

