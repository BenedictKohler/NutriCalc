import 'package:flutter/material.dart';
import 'package:nutri_calc/mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> createPDF(String dName, List<dynamic> drinkVals, List<dynamic> dailyVals) async {
  PdfDocument document = PdfDocument();
  final page = document.pages.add();

  PdfTextElement textElement = PdfTextElement(
      text: dName + " (" + drinkVals[0].toString() + " ml)",
      font: PdfStandardFont(PdfFontFamily.helvetica, 20,
          style: PdfFontStyle.bold));

  PdfLayoutResult layoutResult = textElement.draw(
      page: page,
      bounds: Rect.fromLTWH(
          0, 0, page.getClientSize().width, page.getClientSize().height));

  PdfGrid grid = PdfGrid();
  grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 20),
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
  row.cells[2].value = (drinkVals[2] != 'N/A' && dailyVals[3] != 'ND') ? ((double.parse(drinkVals[2].toString()) / double.parse(dailyVals[3].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Total carbs (g)';
  row.cells[1].value = drinkVals[3].toString();
  row.cells[2].value = (drinkVals[3] != 'N/A' && dailyVals[1] != 'ND') ? ((double.parse(drinkVals[3].toString()) / double.parse(dailyVals[1].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Sugars (g)';
  row.cells[1].value = drinkVals[4].toString();
  row.cells[2].value = 'NA';

  row = grid.rows.add();
  row.cells[0].value = 'Dietary fiber (g)';
  row.cells[1].value = drinkVals[5].toString();
  row.cells[2].value = (drinkVals[5] != 'N/A' && dailyVals[2] != 'ND') ? ((double.parse(drinkVals[5].toString()) / double.parse(dailyVals[2].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Protein (g)';
  row.cells[1].value = drinkVals[6].toString();
  row.cells[2].value = (drinkVals[6] != 'N/A' && dailyVals[4] != 'ND') ? ((double.parse(drinkVals[6].toString()) / double.parse(dailyVals[4].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Cholestrol (mg)';
  row.cells[1].value = drinkVals[7].toString();
  row.cells[2].value = 'NA';

  row = grid.rows.add();
  row.cells[0].value = 'water g(ml)';
  row.cells[1].value = drinkVals[8].toString();
  row.cells[2].value = (drinkVals[8] != 'N/A' && dailyVals[0] != 'ND') ? ((double.parse(drinkVals[8].toString()) / double.parse(dailyVals[0].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Vit A IU';
  row.cells[1].value = drinkVals[9].toString();
  row.cells[2].value = (drinkVals[9] != 'N/A' && dailyVals[5] != 'ND') ? ((double.parse(drinkVals[9].toString()) / double.parse(dailyVals[5].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Vit C (mg)';
  row.cells[1].value = drinkVals[10].toString();
  row.cells[2].value = (drinkVals[10] != 'N/A' && dailyVals[6] != 'ND') ? ((double.parse(drinkVals[10].toString()) / double.parse(dailyVals[6].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Vit D IU';
  row.cells[1].value = drinkVals[11].toString();
  row.cells[2].value = (drinkVals[11] != 'N/A' && dailyVals[7] != 'ND') ? ((double.parse(drinkVals[11].toString()) / double.parse(dailyVals[7].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Vit E IU';
  row.cells[1].value = drinkVals[12].toString();
  row.cells[2].value = (drinkVals[12] != 'N/A' && dailyVals[8] != 'ND') ? ((double.parse(drinkVals[12].toString()) / double.parse(dailyVals[8].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Vit K (mcg)';
  row.cells[1].value = drinkVals[13].toString();
  row.cells[2].value = (drinkVals[13] != 'N/A' && dailyVals[9] != 'ND') ? ((double.parse(drinkVals[13].toString()) / double.parse(dailyVals[9].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'folic acid (mcg)';
  row.cells[1].value = drinkVals[14].toString();
  row.cells[2].value = (drinkVals[14] != 'N/A' && dailyVals[14] != 'ND') ? ((double.parse(drinkVals[14].toString()) / double.parse(dailyVals[14].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Thiamin/Vit B1 (mg)';
  row.cells[1].value = drinkVals[15].toString();
  row.cells[2].value = (drinkVals[15] != 'N/A' && dailyVals[10] != 'ND') ? ((double.parse(drinkVals[15].toString()) / double.parse(dailyVals[10].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Riboflavin/Vit B2 (mg)';
  row.cells[1].value = drinkVals[16].toString();
  row.cells[2].value = (drinkVals[16] != 'N/A' && dailyVals[11] != 'ND') ? ((double.parse(drinkVals[16].toString()) / double.parse(dailyVals[11].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Vit B6 (mg)';
  row.cells[1].value = drinkVals[17].toString();
  row.cells[2].value = (drinkVals[17] != 'N/A' && dailyVals[13] != 'ND') ? ((double.parse(drinkVals[17].toString()) / double.parse(dailyVals[13].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Vit B12 (mcg)';
  row.cells[1].value = drinkVals[18].toString();
  row.cells[2].value = (drinkVals[18] != 'N/A' && dailyVals[15] != 'ND') ? ((double.parse(drinkVals[18].toString()) / double.parse(dailyVals[15].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'niacin (mg)';
  row.cells[1].value = drinkVals[19].toString();
  row.cells[2].value = (drinkVals[19] != 'N/A' && dailyVals[12] != 'ND') ? ((double.parse(drinkVals[19].toString()) / double.parse(dailyVals[12].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'biotin (mcg)';
  row.cells[1].value = drinkVals[20].toString();
  row.cells[2].value = (drinkVals[20] != 'N/A' && dailyVals[17] != 'ND') ? ((double.parse(drinkVals[20].toString()) / double.parse(dailyVals[17].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'pantothenic acid (mg)';
  row.cells[1].value = drinkVals[21].toString();
  row.cells[2].value = (drinkVals[21] != 'N/A' && dailyVals[16] != 'ND') ? ((double.parse(drinkVals[21].toString()) / double.parse(dailyVals[16].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'inositol(mg)';
  row.cells[1].value = drinkVals[22].toString();
  row.cells[2].value = 'NA';

  row = grid.rows.add();
  row.cells[0].value = 'sodium (mg)';
  row.cells[1].value = drinkVals[23].toString();
  row.cells[2].value = (drinkVals[23] != 'N/A' && dailyVals[31] != 'ND') ? ((double.parse(drinkVals[23].toString()) / double.parse(dailyVals[31].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'calcium (mg)';
  row.cells[1].value = drinkVals[24].toString();
  row.cells[2].value = (drinkVals[24] != 'N/A' && dailyVals[18] != 'ND') ? ((double.parse(drinkVals[24].toString()) / double.parse(dailyVals[18].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'potassium (mg)';
  row.cells[1].value = drinkVals[25].toString();
  row.cells[2].value = (drinkVals[25] != 'N/A' && dailyVals[30] != 'ND') ? ((double.parse(drinkVals[25].toString()) / double.parse(dailyVals[30].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'chloride (mg)';
  row.cells[1].value = drinkVals[26].toString();
  row.cells[2].value = (drinkVals[26] != 'N/A' && dailyVals[32] != 'ND') ? ((double.parse(drinkVals[26].toString()) / double.parse(dailyVals[32].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'phosphorus (mg)';
  row.cells[1].value = drinkVals[27].toString();
  row.cells[2].value = (drinkVals[27] != 'N/A' && dailyVals[27] != 'ND') ? ((double.parse(drinkVals[27].toString()) / double.parse(dailyVals[27].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'magnesium (mg)';
  row.cells[1].value = drinkVals[28].toString();
  row.cells[2].value = (drinkVals[28] != 'N/A' && dailyVals[24] != 'ND') ? ((double.parse(drinkVals[28].toString()) / double.parse(dailyVals[24].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'iodine (mcg)';
  row.cells[1].value = drinkVals[29].toString();
  row.cells[2].value = (drinkVals[29] != 'N/A' && dailyVals[22] != 'ND') ? ((double.parse(drinkVals[29].toString()) / double.parse(dailyVals[22].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'manganese (mg)';
  row.cells[1].value = drinkVals[30].toString();
  row.cells[2].value = (drinkVals[30] != 'N/A' && dailyVals[25] != 'ND') ? ((double.parse(drinkVals[30].toString()) / double.parse(dailyVals[25].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'copper (mg)';
  row.cells[1].value = drinkVals[31].toString();
  row.cells[2].value = (drinkVals[31] != 'N/A' && dailyVals[20] != 'ND') ? ((double.parse(drinkVals[31].toString()) / double.parse(dailyVals[20].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'zinc (mg)';
  row.cells[1].value = drinkVals[32].toString();
  row.cells[2].value = (drinkVals[32] != 'N/A' && dailyVals[29] != 'ND') ? ((double.parse(drinkVals[32].toString()) / double.parse(dailyVals[29].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'iron (mg)';
  row.cells[1].value = drinkVals[33].toString();
  row.cells[2].value = (drinkVals[33] != 'N/A' && dailyVals[23] != 'ND') ? ((double.parse(drinkVals[33].toString()) / double.parse(dailyVals[23].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'selenium (mcg)';
  row.cells[1].value = drinkVals[34].toString();
  row.cells[2].value = (drinkVals[34] != 'N/A' && dailyVals[28] != 'ND') ? ((double.parse(drinkVals[34].toString()) / double.parse(dailyVals[28].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'chromium (mcg)';
  row.cells[1].value = drinkVals[35].toString();
  row.cells[2].value = (drinkVals[35] != 'N/A' && dailyVals[19] != 'ND') ? ((double.parse(drinkVals[35].toString()) / double.parse(dailyVals[19].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'molybdenum (mcg)';
  row.cells[1].value = drinkVals[36].toString();
  row.cells[2].value = (drinkVals[36] != 'N/A' && dailyVals[26] != 'ND') ? ((double.parse(drinkVals[36].toString()) / double.parse(dailyVals[26].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'choline (mg)';
  row.cells[1].value = drinkVals[37].toString();
  row.cells[2].value = (drinkVals[37] != 'N/A' && dailyVals[33] != 'ND') ? ((double.parse(drinkVals[37].toString()) / double.parse(dailyVals[33].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'linoleic acid (mg)';
  row.cells[1].value = drinkVals[38].toString();
  row.cells[2].value = (drinkVals[38] != 'N/A' && dailyVals[34] != 'ND') ? ((double.parse(drinkVals[38].toString()) / double.parse(dailyVals[34].toString())) * 100).toStringAsFixed(2) : 'ND';

  row = grid.rows.add();
  row.cells[0].value = 'Beta-carotene (mg)';
  row.cells[1].value = drinkVals[39].toString();
  row.cells[2].value = 'NA';

  row = grid.rows.add();
  row.cells[0].value = 'Taurine (mg)';
  row.cells[1].value = drinkVals[40].toString();
  row.cells[2].value = 'NA';

  grid.draw(
      page: page,
      bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 50, 0, 0));

  List<int> bytes = document.save();
  document.dispose();

  saveAndLauchFile(bytes, 'Output.pdf');
}
