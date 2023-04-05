import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileIoClass {
  FileIoClass({required this.fileName});

  String fileName;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path); // TODO: remove
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<File> writeContent(String content) async {
    final file = await _localFile;
    return file.writeAsString('$content\n', mode: FileMode.append);
  }

  Future<String> readcontent() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If there is an error reading, return a default String
      return 'Error';
    }
  }
}
