import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/controllers/auth_controller.dart';

class ReportController {
  Future<void> saveReport(ReportModel report) async {
    try {
      await FirebaseFirestore.instance
          .collection('Reports')
          .add(report.toJson());

      kFileReports.writeContent(jsonEncode(report.toJson()));
    } catch (e) {
      print(e);
    }
  }

  Future<List<ReportModel>> getReportsByUserId(String userEmail) async {
    List<ReportModel> reports = [];
    try {
      await FirebaseFirestore.instance
          .collection('Reports')
          .get()
          .then((snapshot) => snapshot.docs.forEach((document) {
                if (document.data()['createdBy'] ==
                    AuthController().currentUser!.email) {
                  reports.add(ReportModel.fromJson(document.data()));
                }
              }));
    } catch (e) {
      print(e);
    } finally {
      return reports;
    }
  }
}
