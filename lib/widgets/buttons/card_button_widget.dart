import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/pages/handyman/report_map_page.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CardButtonWidget extends StatelessWidget {
  const CardButtonWidget({
    super.key,
    required this.text,
    required this.reports,
    required this.index,
  });

  final String text;
  final List<ReportModel> reports;
  final int index;

  Color getBackgroundColor(int index) {
    return kListColorReports[index % kListColorReports.length];
  }

  // https://stackoverflow.com/questions/946544/good-text-foreground-color-for-a-given-background-color
  Color getForegroundColor(Color background) {
    double brightness = (0.299 * background.red +
        0.587 * background.green +
        0.114 * background.blue); // convert into gray scale

    return brightness > 186 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = getBackgroundColor(index);
    var foregroundColor = getForegroundColor(backgroundColor);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ReportMapPage(
                title: text,
                reports: reports,
              );
            },
          ),
        );
      },
      child: Card(
        color: backgroundColor,
        child: Container(
          padding: const EdgeInsets.all(kDouble25),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: foregroundColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
