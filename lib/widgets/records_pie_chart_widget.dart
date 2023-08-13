import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:corriol_app/providers/report_provider.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordsPieChartWidget extends StatelessWidget {
  const RecordsPieChartWidget({super.key, required this.species});

  final Species species;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final preferences = userProvider.preferences as UserPreferencesModel;

        if (preferences.mobileData == false) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              Text(S.current.cannotBeViewedWithoutInternet),
            ],
          );
        } else {
          return Consumer<ReportProvider>(
            builder: (context, reportProvider, child) {
              final reports = reportProvider.userReports;

              if (reports.isEmpty) {
                return const Center(child: Text("No hi ha cap avistament"));
              } else {
                var femelles = 0;
                var polls = 0;
                var mascles = 0;
                var indeterminat = 0;
                var gossos = 0;
                var gats = 0;

                for (var report in reports) {
                  if (report.species != species) continue;

                  femelles += report.females;
                  polls += report.chickens;
                  mascles += report.males;
                  indeterminat += report.undetermined;
                  gossos += report.dogs;
                  gats += report.cats;
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
                return SizedBox(
                  width: 300,
                  height: 300,
                  child: PieChart(
                    PieChartData(
                      sections: data,
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
