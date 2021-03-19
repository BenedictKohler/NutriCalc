import 'package:flutter/material.dart';
import 'package:nutri_calc/AddFormulaScreen.dart';


class SettingsScreen extends StatefulWidget {
  static const id = 'settingsscreen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _fNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Settings'),
        backgroundColor: Colors.red,),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    elevation: 5,
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
                    onPressed: ()  {
                      Navigator.pushNamed(context, AddFormulaScreen.id);
                    },
                  ),
                  RaisedButton(
                    elevation: 5,
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
                    onPressed: ()  {
                      throw new Exception("Not implemented yet");
                    },
                  ),
                  RaisedButton(
                    elevation: 5,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.black87,
                          ),
                        ),
                        Text('Other settings...'),
                      ],
                    ),
                    onPressed: ()  {
                      throw new Exception("Not implemented yet");
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
