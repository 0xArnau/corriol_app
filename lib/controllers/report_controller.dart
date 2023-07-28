import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:logger/logger.dart';

/// Class that provides functionality to the [ReportModel] class.
class ReportController {
  /// Saves a report either to [FirebaseFirestore] or locally based on the internet connection status.
  ///
  /// If [isConnection] is `true`, the report will be saved to [FirebaseFirestore] and then will also save the locally stored [ReportModel] to [FirebaseFirestore].
  /// If [isConnection] is `false`, the report will be saved only locally as there is
  /// no internet connection to save it to [FirebaseFirestore].
  void saveReport(ReportModel report, bool isConnection) {
    if (isConnection) {
      _saveReport2Firestore(report);
      _saveLocalReports2Firestore();
    } else {
      _saveReportLocally(report);
    }
  }

  /// Saves a [UserModel] locally in a JSON file when there is no internet connection.
  Future<void> _saveReportLocally(ReportModel report) async {
    kFileReportsWithoutConnection.writeContent(jsonEncode(report.toJson()));
  }

  /// Saves a [UserModel] to [FirebaseFirestore].
  Future<void> _saveReport2Firestore(ReportModel report) async {
    try {
      await FirebaseFirestore.instance
          .collection('Reports')
          .add(report.toJson());
    } catch (e) {
      Logger().e(e);
    }
  }

  /// Saves locally stored [ReportModel] to [FirebaseFirestore].
  Future<void> _saveLocalReports2Firestore() async {
    try {
      if (await kFileReportsWithoutConnection.fileExists()) {
        final String? content =
            await kFileReportsWithoutConnection.readContent();
        if (content != null) {
          final contentList = content.split("\n");
          for (var element in contentList) {
            if (element.isNotEmpty) {
              _saveReport2Firestore(ReportModel.fromJson(jsonDecode(element)));
            }
          }
        }
      }
      kFileReportsWithoutConnection.deleteFile();
    } catch (e) {
      Logger().e(e);
    }
  }

  /// Retrieves a [List<ReportModel>] associated with a specific [UserModel].
  ///
  /// The [userEmail] parameter specifies the email address of the user for whom
  /// the reports are to be retrieved.
  Future<List<ReportModel>> getReportsByUserId(String userEmail) async {
    _saveLocalReports2Firestore();

    try {
      List<ReportModel> reports = [];
      await FirebaseFirestore.instance
          .collection('Reports')
          .get()
          .then((snapshot) {
        for (var document in snapshot.docs) {
          if (document.data()['createdBy'] ==
              AuthController().currentUser!.email) {
            reports.add(ReportModel.fromJson(document.data()));
          }
        }
      });
      return reports;
    } catch (e) {
      Logger().e(e);
    }

    return [];
  }

  /// Retrieves a list of all [ReportModel] from [FirebaseFirestore].
  Future<List<ReportModel>> getAllReports() async {
    _saveLocalReports2Firestore();

    try {
      List<ReportModel> reports = [];
      await FirebaseFirestore.instance
          .collection('Reports')
          .get()
          .then((snapshot) {
        for (var document in snapshot.docs) {
          reports.add(ReportModel.fromJson(document.data()));
        }
      });
      return reports;
    } catch (e) {
      Logger().e(e);
    }

    return [];
  }
}
