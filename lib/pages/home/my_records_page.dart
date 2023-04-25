import 'dart:ffi';

import 'package:corriol_app/classes/record_observations_class.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MyRecordsPage extends StatefulWidget {
  const MyRecordsPage({super.key});

  @override
  State<MyRecordsPage> createState() => _MyRecordsPageState();
}

class _MyRecordsPageState extends State<MyRecordsPage> {
  late Future<List<RecordObservationClass>> records;

  @override
  void initState() {
    super.initState();

    records = RecordObservationClass.loadRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).myRecords,
          style: kTextStylePageTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDouble15),
        child: FutureBuilder<List<RecordObservationClass>>(
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
                femelles += element.females;
                polls += element.chickens;
                mascles += element.males;
                indeterminat += element.undetermined;
                gossos += element.dogs;
                gats += element.cats;
              }

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

              return PieChart(
                PieChartData(
                  sections: data,
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
