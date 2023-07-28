import 'dart:async';
import 'dart:io';
import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/utils/my_snackbar.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Class that provides functionality to Input/Output files
class FileIoController {
  /// Constructor to create a [FileIoController] instance.
  FileIoController({required this.fileName});

  /// The name of the file to work with.
  String fileName;

  /// Gets the path for the application's document directory using [path_provider.getApplicationDocumentsDirectory].
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// Gets the file based on the [fileName] and [_pathPath].
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  /// Deletes the [_localFile]
  Future<void> deleteFile() async {
    final file = await _localFile;
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Checks if the [_localFile] exists.
  Future<bool> fileExists() async {
    final file = await _localFile;
    return file.exists();
  }

  /// Writes content to the [_localFile] in append mode.
  Future<File> writeContent(String content) async {
    final file = await _localFile;
    return file.writeAsString('$content\n', mode: FileMode.append);
  }

  /// Re-writes content to the [_fileName] in write mode.
  Future<File> reWriteContent(String content) async {
    final file = await _localFile;
    return file.writeAsString(content, mode: FileMode.write);
  }

  /// Reads the content from the [_localFile].
  ///
  /// Returns the contents as a [String], or `null` if there was an error reading the file.
  Future<String?> readContent() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  /// Requests the permission (using [permission_handler]) for file storage and returns whether the permission is granted.
  static Future<bool> _permissionStorage(Permission permission) async {
    if (await permission.isGranted) return true;

    return (await permission.request().isGranted) ? true : false;
  }

  /// Saves a list of [ReportModel] objects to a CSV file (using [csv.ListToCsvConverter]) in the device storage.
  ///
  /// The [reports] list contains the data to be written to the CSV file.
  /// The [context] is required to display a snackbar with the result of the operation.
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
      'coordinates',
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
        report.coordinates,
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
            .then((_) => snackbarInfo(context, S.current.fileSave))
            .onError((error, stackTrace) => snackbarInfo(context, "$error"));
      } else {
        snackbarInfo(context, S.current.directoryDoesntExist);
      }
    });
  }
}
