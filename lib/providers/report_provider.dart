import 'package:corriol_app/controllers/report_controller.dart';
import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

class ReportProvider extends ChangeNotifier {
  /// Stores all the reports made by all users, the reports are grouped by locality
  Map<String, List<ReportModel>> locality = {};

  /// Stores all the reports made by the current user
  List<ReportModel> userReports = [];

  /// Fetches the [locality] reports from thew [ReportController.getAllReports], sorts and groups them by locality
  void fetchAllReports(BuildContext context, bool internetConnection) async {
    if (internetConnection) {
      final List<ReportModel> reports =
          await ReportController().getAllReports();
      Map<String, List<ReportModel>> map = {};

      for (var elem in reports) {
        if (elem.locality.isEmpty) {
          if (map.containsKey("unknown")) {
            map["unknown"]!.add(elem);
          } else {
            map["unknown"] = [elem];
          }
        } else if (map.containsKey(elem.locality)) {
          map[elem.locality]!.add(elem);
        } else {
          map[elem.locality] = [elem];
        }
      }

      List<String> keys = map.keys.toList();
      keys.sort();

      locality = {};

      for (var key in keys) {
        locality[key] = map[key]!;
      }

      notifyListeners();
    } else {
      snackbarError(context, S.current.noInternetConnection);
    }
  }

  void fetchCurrentUserReports(
      BuildContext context, String email, bool internetConnection) async {
    if (internetConnection) {
      userReports = await ReportController().getReportsByUserId(email);

      notifyListeners();
    } else {
      snackbarError(context, S.current.noInternetConnection);
    }
  }
}
