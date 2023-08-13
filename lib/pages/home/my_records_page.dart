import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/providers/report_provider.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:corriol_app/utils/my_snackbar.dart';
import 'package:corriol_app/widgets/legend_pie_chart_widget.dart';
import 'package:corriol_app/widgets/records_pie_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A page that displays the user's [ReportModel], categorized by two [Species].
class MyRecordsPage extends StatefulWidget {
  const MyRecordsPage({super.key});

  @override
  State<MyRecordsPage> createState() => _MyRecordsPageState();
}

class _MyRecordsPageState extends State<MyRecordsPage> {
  final List<Widget> charts = [
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
    final List<Widget> basicStart = [
      const SizedBox(height: kDouble25),
    ];
    final List<Widget> basicEnd = [
      const SizedBox(height: kDouble25),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          charts[0],
          const Spacer(),
          charts[1],
          const Spacer(),
        ],
      ),
      const SizedBox(height: kDouble25),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          charts[2],
          const Spacer(),
          charts[3],
          const Spacer(),
        ],
      ),
      const SizedBox(height: kDouble25),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          charts[4],
          const Spacer(),
          charts[5],
          const Spacer(),
        ],
      ),
      const SizedBox(height: kDouble25),
      const Image(image: AssetImage('assets/images/GEPEC_EdC_OFICIAL.png')),
    ];

    List<Widget> camanegre = [
      ...basicStart,
      const RecordsPieChartWidget(
        species: Species.corriolCamanegre,
      ),
      ...basicEnd,
    ];
    List<Widget> petit = [
      ...basicStart,
      const RecordsPieChartWidget(
        species: Species.corriolPetit,
      ),
      ...basicEnd,
    ];

    return Consumer<ReportProvider>(
      builder: (context, value, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                S.current.myRecords,
                style: kTextStylePageTitle,
              ),
              bottom: TabBar(
                indicatorColor: kColorText,
                labelColor: kColorText,
                // isScrollable: true,
                tabs: [
                  Tab(
                    text: S.current.corriolCamanegre,
                  ),
                  Tab(
                    text: S.current.corriolPetit,
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    final user =
                        Provider.of<UserProvider>(context, listen: false).user;
                    if (user != null) {
                      value.fetchCurrentUserReports(
                        context,
                        user.email,
                        Provider.of<UserProvider>(context, listen: false)
                            .preferences
                            .mobileData,
                      );
                    } else {
                      snackbarError(context, S.current.unknownError);
                    }
                  },
                  icon: const Icon(
                    Icons.update,
                  ),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                ListView.builder(
                  itemCount: camanegre.length,
                  itemBuilder: (BuildContext context, int index) {
                    return camanegre[index];
                  },
                ),
                ListView.builder(
                  itemCount: petit.length,
                  itemBuilder: (BuildContext context, int index) {
                    return petit[index];
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
