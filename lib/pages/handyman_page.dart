import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:corriol_app/widgets/buttons/card_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HandymanPage extends StatefulWidget {
  const HandymanPage({super.key});

  @override
  State<HandymanPage> createState() => _HandymanPageState();
}

class _HandymanPageState extends State<HandymanPage> {
  List<Widget> generateKeyButton(Map<String, List<ReportModel>> map) {
    List<Widget> widgets = [];
    map.forEach((key, value) {
      widgets.add(CardButtonWidget(
        text: key,
        reports: value,
      ));
    });

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: Consumer<UserProvider>(
          builder: (context, value, child) {
            Map<String, List<ReportModel>> map = value.locality;
            List<Widget> addressSubAdministrativeArea = generateKeyButton(map);
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: addressSubAdministrativeArea.length,
              itemBuilder: (context, index) {
                return addressSubAdministrativeArea[index];
              },
            );
          },
        ),
      ),
    );
  }
}
