import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart' as material;
import 'package:nutri_calc/PdfViewPage.dart';
//

reportView(context, output) async {
  final Document pdf = Document();

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  await file.writeAsBytes(pdf.save());
  material.Navigator.of(context).push(
    material.MaterialPageRoute(
      builder: (_) => PdfViewPage(path: path),
    ),
  );

  pdf.addPage(Page(
      pageFormat: PdfPageFormat.a4,
      build: (Context context) {
        return Center(
            child: Column(
                children: <Widget>[
                  Header(
                      level: 0,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Report', textScaleFactor: 2),
                            PdfLogo()
                          ])),
                  Header(level: 1, text: 'Calculation'),
                  Paragraph(text: 'Maybe put drink name, other info here'),
                  Padding(padding: const EdgeInsets.all(10)),
                  Table.fromTextArray(
                      context: context, data: const <List<String>>[
                    <String>['Ingredient', 'Amount', '%DV'],
                    <String>['Protein', '34', '100'],
                    <String>['Carb', '24', '50'],
                    <String>['Fat', '19', '32'],
                  ]),
                ])
        );
      }));
}
