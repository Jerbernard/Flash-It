import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class TextStorage {
  Future<String> get _qlocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _qlocalFile async {
    final path = await _qlocalPath;
    return File('$path/text.txt');
  }

  Future<String> readFile() async {
    try {
      final file = await _qlocalFile;

      String content = await file.readAsString();
      return content;
    } catch (e) {
      return '';
    }
  }

  Future<File> writeFile(String text) async {
    final file = await _qlocalFile;
    return file.writeAsString('$text\r\n', mode: FileMode.append);
  }

  Future<File> cleanFile() async {
    final file = await _qlocalFile;
    return file.writeAsString('');
  }
}
