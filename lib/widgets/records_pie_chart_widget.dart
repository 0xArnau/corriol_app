import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/controllers/report_controller.dart';
import 'package:corriol_app/core/notifiers.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RecordsPieChartWidget extends StatefulWidget {
  const RecordsPieChartWidget({super.key, required this.species});

  final Species species;

  @override
  State<RecordsPieChartWidget> createState() => _RecordsPieChartWidgetState();
}

class _RecordsPieChartWidgetState extends State<RecordsPieChartWidget> {
  late Future<List<ReportModel>> records;

  @override
  void initState() {
    super.initState();

    print("is connected? ${isConnectedNotifier.value}");

    if (isConnectedNotifier.value) {
      records = ReportController()
          .getReportsByUserId(AuthController().currentUser!.email!);
    } else {
      records = ReportModel.loadRecords();
    }
    print("records ${records}");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReportModel>>(
      future: records,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var femelles = 0;
          var polls = 0;
          var mascles = 0;
          var indeterminat = 0;
          var gossos = 0;
          var gats = 0;
          final _records = snapshot.data!;

          for (final element in _records) {
            print(element.toJson());

            if (element.species != widget.species) continue;

            femelles += element.females;
            polls += element.chickens;
            mascles += element.males;
            indeterminat += element.undetermined;
            gossos += element.dogs;
            gats += element.cats;
          }

          print("femelles ${femelles}");
          print("polls ${polls}");
          print("mascles ${mascles}");
          print("indeterminats ${indeterminat}");
          print("gossos ${gossos}");
          print("gats ${gats}");

          final data = [
            PieChartSectionData(
              value: femelles.toDouble(),
              color: kColorList['femelles'],
              radius: 50,
            ),
            PieChartSectionData(
              value: polls.toDouble(),
              color: kColorList['polls'],
              radius: 50,
            ),
            PieChartSectionData(
              value: mascles.toDouble(),
              color: kColorList['mascles'],
              radius: 50,
            ),
            PieChartSectionData(
              value: indeterminat.toDouble(),
              color: kColorList['indeterminat'],
              radius: 50,
            ),
            PieChartSectionData(
              value: gossos.toDouble(),
              color: kColorList['gossos'],
              radius: 50,
            ),
            PieChartSectionData(
              value: gats.toDouble(),
              color: kColorList['gats'],
              radius: 50,
            ),
          ];

          return SizedBox(
            width: 300,
            height: 300,
            child: PieChart(
              PieChartData(
                sections: data,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('No data found'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
