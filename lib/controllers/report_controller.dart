// import 'dart:convert';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corriol_app/core/constants.dart';
// import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:logger/logger.dart';

class ReportController {
  void saveReport(ReportModel report, bool isConnection) {
    if (isConnection) {
      _saveReport2Firestore(report);
      _saveLocalReports2Firestore();
    } else {
      _saveReportLocally(report);
    }
  }

  Future<void> _saveReportLocally(ReportModel report) async {
    kFileReportsWithoutConnection.writeContent(jsonEncode(report.toJson()));
  }

  Future<void> _saveReport2Firestore(ReportModel report) async {
    try {
      await FirebaseFirestore.instance
          .collection('Reports')
          .add(report.toJson());
    } catch (e) {
      Logger().e(e);
    }
  }

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
