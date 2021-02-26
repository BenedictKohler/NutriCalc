import 'package:flutter/material.dart';

class AddFormulaScreen extends StatefulWidget {
  static const id = 'addformulascreen';
  @override
  _AddFormulaScreenState createState() => _AddFormulaScreenState();
}

class _AddFormulaScreenState extends State<AddFormulaScreen> {
  final _fNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Formula')),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: _fNameController,
                      decoration: InputDecoration(
                        hintText: 'Enter formula name',
                        fillColor: Colors.lightBlueAccent,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      obscureText: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Your formula must have a name';
                        }
                        return null;
                      },
                    ),
                  ),
                  RaisedButton(
                    elevation: 5,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.save,
                            color: Colors.black87,
                          ),
                        ),
                        Text('Save Formula'),
                      ],
                    ),
                    onPressed: () async {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Saving Formula'),
                        backgroundColor: Colors.lightBlueAccent,
                      ));
                      Future.delayed(Duration(seconds: 2))
                          .then((value) => Navigator.pop(context));
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
