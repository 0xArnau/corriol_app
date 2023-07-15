import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/widgets/legend_pie_chart_widget.dart';
import 'package:corriol_app/widgets/records_pie_chart_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MyRecordsPage extends StatefulWidget {
  const MyRecordsPage({super.key});

  @override
  State<MyRecordsPage> createState() => _MyRecordsPageState();
}

class _MyRecordsPageState extends State<MyRecordsPage> {
  final List<LegendPieChartWidget> charts = [
    // Widgets en el GridView
    LegendPieChartWidget(
      color: kColorList['femelles']!,
      text: 'Femelles',
    ),
    LegendPieChartWidget(
      color: kColorList['polls']!,
      text: 'Polls',
    ),
    LegendPieChartWidget(
      color: kColorList['mascles']!,
      text: 'Mascles',
    ),
    LegendPieChartWidget(
      color: kColorList['indeterminat']!,
      text: 'Indeterminat',
    ),
    LegendPieChartWidget(
      color: kColorList['gossos']!,
      text: 'Gossos',
    ),
    LegendPieChartWidget(
      color: kColorList['gats']!,
      text: 'Gats',
    ),
  ];
  bool isOptionA = true; // Corriol camanegre (true), Corriol petit (false)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).myRecords,
          style: kTextStylePageTitle,
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              switch (index) {
                case 0:
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Corriol petit'),
                      Switch(
                        value: isOptionA,
                        onChanged: (value) {
                          setState(() {
                            isOptionA = value;
                          });
                        },
                      ),
                      const Text('Corriol camanegre'),
                    ],
                  );
                case 1:
                  return const SizedBox(height: kDouble25);
                case 2:
                  return Visibility(
                    visible: isOptionA,
                    child: const RecordsPieChartWidget(
                      species: Species.corriolCamanegre,
                    ),
                  );
                case 3:
                  return Visibility(
                    visible: !isOptionA,
                    child: const RecordsPieChartWidget(
                      species: Species.corriolPetit,
                    ), // Corriol petit
                  );
                case 4:
                  return const SizedBox(height: kDouble25);
                case 5:
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      charts[0],
                      const Spacer(),
                      charts[1],
                      const Spacer(),
                    ],
                  );
                case 6:
                  return const SizedBox(height: kDouble15);
                case 7:
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      charts[2],
                      const Spacer(),
                      charts[3],
                      const Spacer(),
                    ],
                  );
                case 8:
                  return const SizedBox(height: kDouble15);
                case 9:
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      charts[4],
                      const Spacer(),
                      charts[5],
                      const Spacer(),
                    ],
                  );
                case 10:
                  return const SizedBox(height: kDouble15);
                default:
                  return const SizedBox();
              }
            },
          ),
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Image(
              image: AssetImage('assets/images/GEPEC_EdC_OFICIAL.png'),
            ),
          ),
        ],
      ),
    );
  }
}
