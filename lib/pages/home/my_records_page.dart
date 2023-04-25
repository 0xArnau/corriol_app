import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/widgets/legend_pie_chart_widget.dart';
import 'package:corriol_app/widgets/records_pie_chart_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MyRecordsPage extends StatelessWidget {
  const MyRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).myRecords,
          style: kTextStylePageTitle,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kDouble15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RecordsPieChartWidget(),
              const SizedBox(height: kDouble25),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: [
                      // Widgets en el GridView
                      LegendPieChartWidget(
                          color: kColorList['femelles']!, text: 'Femelles'),
                      LegendPieChartWidget(
                          color: kColorList['polls']!, text: 'Polls'),
                      LegendPieChartWidget(
                          color: kColorList['mascles']!, text: 'Mascles'),
                      LegendPieChartWidget(
                          color: kColorList['indeterminat']!,
                          text: 'Indeterminat'),
                      LegendPieChartWidget(
                          color: kColorList['gossos']!, text: 'Gossos'),
                      LegendPieChartWidget(
                          color: kColorList['gats']!, text: 'Gats'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: kDouble15),
              const Image(
                image: AssetImage('assets/images/GEPEC_EdC_OFICIAL.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
