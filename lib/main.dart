import 'package:flutter/material.dart';
import 'AddFormulaScreen.dart';
import 'HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        AddFormulaScreen.id: (context) => AddFormulaScreen()
      },
    );
  }
}
