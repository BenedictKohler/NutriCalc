import 'dart:collection';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DailyDataHelper {
  Directory _documents;

  /* Writes the data to file on users phone if not already there
     and then gets text data into list and returns it */
  Future<List<List<dynamic>>> GetDataList() async {
    String textData = "";
    _documents = await getApplicationDocumentsDirectory();
    if (!await IsPopulated()) {
      String data = await rootBundle.loadString('assets/daily.csv');
      try {
        File file = new File('${_documents.path}/daily.csv');
        file.open(mode: FileMode.append);
        file = await file.writeAsString(data, flush: true);
      } catch (e) {}
    }

    try {
      File file = new File('${_documents.path}/daily.csv');
      file.open(mode: FileMode.append);
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
    File file = new File('${_documents.path}/daily.csv');
    try {
      if (file.existsSync()) return true;
    } catch (e) {}
    return false;
  }

}
