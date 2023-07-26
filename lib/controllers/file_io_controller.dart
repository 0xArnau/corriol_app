import 'dart:async';
import 'dart:io';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/utils/my_snackbar.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FileIoController {
  FileIoController({required this.fileName});

  String fileName;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<void> deleteFile() async {
    final file = await _localFile;
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<bool> fileExists() async {
    final file = await _localFile;
    return file.exists();
  }

  Future<File> writeContent(String content) async {
    final file = await _localFile;
    return file.writeAsString('$content\n', mode: FileMode.append);
  }

  Future<File> reWriteContent(String content) async {
    final file = await _localFile;
    return file.writeAsString(content, mode: FileMode.write);
  }

  ///
  Future<String?> readContent() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If there is an error reading, return a default String
      return null;
    }
  }

  static Future<bool> _permissionStorage(Permission permission) async {
    if (await permission.isGranted) return true;

    return (await permission.request().isGranted) ? true : false;
  }

  static void saveReports2CSV(
      List<ReportModel> reports, BuildContext context) async {
    late String csv;
    late File file;
    Directory? directory;

    if (Platform.isAndroid) {
      if (await _permissionStorage(Permission.storage)) {
        directory = await getExternalStorageDirectory();
      }
    } else {
      if (await _permissionStorage(Permission.storage)) {
        directory = await getApplicationDocumentsDirectory();
      }
    }

    if (directory == null) return;

    file = File(
      "${directory.path}/corriol_app-${DateTime.now().toIso8601String()}.csv",
    );

    List<List<dynamic>> rows = [];

    rows.add([
      'createdBy',
      'createdAt',
      'coordenates',
      'administrativeArea',
      'subAdministrativeArea',
      'locality',
      'species',
      'females',
      'males',
      'undetermined',
      'chickens',
      'dogs',
      'cats'
    ]);

    for (var report in reports) {
      rows.add([
        report.createdBy,
        report.createdAt,
        report.coordenates,
        report.administrativeArea,
        report.subAdministrativeArea,
        report.locality,
        report.species,
        report.females,
        report.males,
        report.undetermined,
        report.chickens,
        report.dogs,
        report.cats,
      ]);
    }

    csv = const ListToCsvConverter().convert(rows);

    directory.exists().then((value) {
      if (value) {
        file
            .writeAsString(csv, mode: FileMode.write)
            .then((_) => snackbarInfo(context, "File saved"))
            .onError((error, stackTrace) => snackbarInfo(context, "$error"));
      } else {
        snackbarInfo(context, "Directory doesn't exists");
      }
    });
  }
}
