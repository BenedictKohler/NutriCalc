import 'package:flutter/material.dart';
import 'package:nutri_calc/TempPdfCreator.dart';
import 'AddFormulaScreen.dart';
import 'CalcForm.dart';
import 'HomeScreen.dart';
import 'SettingsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: TempPdfCreator.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        AddFormulaScreen.id: (context) => AddFormulaScreen(),
        CalcForm.id: (context) => CalcForm(),
        SettingsScreen.id: (context) => SettingsScreen(),
        TempPdfCreator.id: (context) => TempPdfCreator(),
      },
    );
  }
}
