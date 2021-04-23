import 'package:flutter/material.dart';
import 'package:nutri_calc/mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> createPDF(String dName, List<dynamic> drinkVals) async {
  PdfDocument document = PdfDocument();
  final page = document.pages.add();

  /*page.graphics.drawString(
      'Drink Name: ' + dName + " " + drinkVals[0].toString() + "mL",
      PdfStandardFont(PdfFontFamily.helvetica, 30));*/

  PdfTextElement textElement = PdfTextElement(
      text: 'Drink Name: ' + dName + " " + drinkVals[0].toString() + "mL",
      font: PdfStandardFont(PdfFontFamily.helvetica, 12));

  PdfLayoutResult layoutResult = textElement.draw(
      page: page,
      bounds: Rect.fromLTWH(
          0, 150, page.getClientSize().width, page.getClientSize().height));

  //Draw the header text on page, below the paragraph text with a height gap of 20 and maintain the position in PdfLayoutResult
  layoutResult = textElement.draw(
      page: page,
      bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 20, 0, 0));

  PdfGrid grid = PdfGrid();
  grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 30),
      cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

  grid.columns.add(count: 3);
  grid.headers.add(1);

  PdfGridRow header = grid.headers[0];
  header.cells[0].value = 'Nutrient';
  header.cells[1].value = 'Amount';
  header.cells[2].value = '%DV';

  PdfGridRow row = grid.rows.add();
  row.cells[0].value = 'Calories';
  row.cells[1].value = drinkVals[1].toString();
  row.cells[2].value = 'NA';

  row = grid.rows.add();
  row.cells[0].value = 'Total fat (g)';
  row.cells[1].value = drinkVals[2].toString();
  row.cells[2].value = 'NA';

  row = grid.rows.add();
  row.cells[0].value = 'Total carbs (g)';
  row.cells[1].value = drinkVals[3].toString();
  row.cells[2].value = 'NA';

  row = grid.rows.add();
  row.cells[0].value = 'Sugars (g)';
  row.cells[1].value = drinkVals[4].toString();
  row.cells[2].value = 'NA';

  row = grid.rows.add();
  row.cells[0].value = 'Dietary fiber (g)';
  row.cells[1].value = drinkVals[5].toString();
  row.cells[2].value = 'NA';

  row = grid.rows.add();
  row.cells[0].value = 'Protein (g)';
  row.cells[1].value = drinkVals[6].toString();
  row.cells[2].value = 'NA';

  row = grid.rows.add();
  row.cells[0].value = 'Cholestrol (mg)';
  row.cells[1].value = drinkVals[7].toString();
  row.cells[2].value = 'NA';

  textElement.draw(page: page, bounds: const Rect.fromLTWH(0, 50, 0, 0));

  List<int> bytes = document.save();
  document.dispose();

  saveAndLauchFile(bytes, 'Output.pdf');
}
