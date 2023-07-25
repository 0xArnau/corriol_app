import 'package:corriol_app/models/report_model.dart';
import 'package:flutter/material.dart';

class ReportMarkerWidget extends StatelessWidget {
  const ReportMarkerWidget({super.key, required this.report});

  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 2,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("createdBy: ${report.createdBy}"),
              Text("createdAt: ${report.createdAt}"),
              Text("administrativeArea: ${report.administrativeArea}"),
              Text("subAdministrativeArea: ${report.subAdministrativeArea}"),
              Text("locality: ${report.locality}"),
              Text("species: ${report.species}"),
              Text("females: ${report.females}"),
              Text("males: ${report.males}"),
              Text("undetermined: ${report.undetermined}"),
              Text("chickens: ${report.chickens}"),
              Text("dogs: ${report.dogs}"),
              Text("cats: ${report.cats}"),
            ],
          ),
        ),
      ),
    );
  }
}
