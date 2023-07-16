// import 'dart:convert';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corriol_app/core/constants.dart';
// import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/controllers/auth_controller.dart';

class ReportController {
  void saveReport(ReportModel report, bool isConnection) {
    print("save report");
    print(report.toJson());
    if (isConnection) {
      _saveReport2Firestore(report);
      _saveLocalReports2Firestore();
    } else {
      _saveReportLocally(report);
    }
  }

  Future<void> _saveReportLocally(ReportModel report) async {
    print("_saveReportLocally");
    kFileReportsWithoutConnection.writeContent(jsonEncode(report.toJson()));
  }

  Future<void> _saveReport2Firestore(ReportModel report) async {
    print("_saveReport2Firestore");
    print(report.toJson());
    try {
      await FirebaseFirestore.instance
          .collection('Reports')
          .add(report.toJson());
    } catch (e) {
      print("_saveReport2Firestore ${e}");
    }
  }

  Future<void> _saveLocalReports2Firestore() async {
    print("_saveLocalReports2Firestore");
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
      print("_saveLocalReports2Firestore ${e}");
    }
  }

  Future<List<ReportModel>> getReportsByUserId(String userEmail) async {
    try {
      List<ReportModel> reports = [];
      await FirebaseFirestore.instance
          .collection('Reports')
          .get()
          .then((snapshot) => snapshot.docs.forEach((document) {
                if (document.data()['createdBy'] ==
                    AuthController().currentUser!.email) {
                  reports.add(ReportModel.fromJson(document.data()));
                }
              }));
      return reports;
    } catch (e) {
      print(e);
    }

    return [];
  }
}
