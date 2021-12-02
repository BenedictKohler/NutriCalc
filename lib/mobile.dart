import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<void> saveAndLauchFile(List<int> bytes, String fileName) async {
  /* final path = (await getExternalStorageDirectory()).path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName'); */

  final dir = await getApplicationDocumentsDirectory();
  final fullpath = join(dir.path, fileName);

  final file = File(fullpath);
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open(fullpath);

}
