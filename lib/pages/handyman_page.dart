import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/providers/report_provider.dart';
import 'package:corriol_app/widgets/buttons/card_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A page that shows all reports made by all users based on locality.
class HandymanPage extends StatefulWidget {
  const HandymanPage({super.key});

  @override
  State<HandymanPage> createState() => _HandymanPageState();
}

class _HandymanPageState extends State<HandymanPage> {
  Widget _generetatAllCsv(Map<String, List<ReportModel>> map) {
    List<ReportModel> list = [];

    map.forEach((key, value) {
      list.addAll(value);
    });

    return CardButtonWidget(text: S.current.all, reports: list);
  }

  List<Widget> generateKeyButton(Map<String, List<ReportModel>> map) {
    List<Widget> widgets = [];

    map.forEach((key, value) {
      widgets.add(CardButtonWidget(
        text: key,
        reports: value,
      ));
    });

    return widgets.isEmpty
        ? widgets
        : [
            _generetatAllCsv(map),
            ...widgets,
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: Consumer<ReportProvider>(
          builder: (context, value, child) {
            Map<String, List<ReportModel>> map = value.locality;
            List<Widget> locality = generateKeyButton(map);
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: locality.length,
              itemBuilder: (context, index) {
                return locality[index];
              },
            );
          },
        ),
      ),
    );
  }
}
