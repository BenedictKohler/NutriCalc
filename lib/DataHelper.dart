import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DataHelper {
  Directory _documents;

  Future<bool> CreateNewCSV(String path) async {
    if (_documents == null)
      _documents = await getApplicationDocumentsDirectory();
    File file = new File(path);
    file.open(mode: FileMode.append);
    String textData = "";
    try {
      textData = file.readAsStringSync();
    } catch (e) {
      return false;
    }
    if (textData == "")
      return false; // Assume that if its not empty they uploaded a valid file

    File newFile = new File('${_documents.path}/data.csv');
    newFile.open(mode: FileMode.append);

    try {
      await newFile.writeAsString(textData, flush: true);
    } catch (e) {
      return false;
    }

    return true;
  }

  /* Writes the data to file on users phone if not already there
     and then gets text data into list and returns it */
  Future<List<List<dynamic>>> GetDataList() async {
    String textData = "";
    _documents = await getApplicationDocumentsDirectory();
    if (!await IsPopulated()) {
      String data = await rootBundle.loadString('assets/data.csv');
      try {
        File file = new File('${_documents.path}/data.csv');
        file.open(mode: FileMode.append);
        file = await file.writeAsString(data, flush: true);
      } catch (e) {}
    }

    try {
      File file = new File('${_documents.path}/data.csv');
      file.open(mode: FileMode.append);
      textData = file.readAsStringSync();
    } catch (e) {}

    List<List<dynamic>> csvData = convertCSV(textData);
    // List<List<dynamic>> csvData = const CsvToListConverter().convert(textData);
    return csvData;
  }

  // Checks to see if file on users phone has got data already
  Future<bool> IsPopulated() async {
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
    HashMap<String, List<dynamic>> hashMap = new HashMap<String, List<dynamic>>();
    for (int i = 1; i < data.length; i++) {
      hashMap.putIfAbsent(data.elementAt(i).elementAt(0), () => data.elementAt(i));
    }
    return hashMap;
  }

  List<List<dynamic>> convertCSV(String csv) {
    LineSplitter ls = new LineSplitter();
    List<String> lines = ls.convert(csv);
    List<List<dynamic>> res = new List<List<dynamic>>();
    // Add headers
    List<dynamic> rowList = lines.elementAt(0).split(",");
    res.add(rowList);

    for (int i = 1; i < lines.length; i++) {
      List<dynamic> rowList = lines.elementAt(i).split(",");
      List<dynamic> tempList = new List<dynamic>();
      tempList.add(rowList.elementAt(0));
      for (int i = 1; i < rowList.length; i++) {
        String val = rowList.elementAt(i);
        try {
          double num = double.parse(val);
          tempList.add(num);
        }
        catch (e) {
          tempList.add("N/A");
        }
      }
      res.add(tempList);
    }
    return res;
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
