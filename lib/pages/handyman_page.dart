import 'package:corriol_app/controllers/report_controller.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/widgets/buttons/black_button_widget.dart';
import 'package:corriol_app/widgets/buttons/card_button_widget.dart';
import 'package:flutter/material.dart';

class HandymanPage extends StatefulWidget {
  const HandymanPage({super.key});

  @override
  State<HandymanPage> createState() => _HandymanPageState();
}

class _HandymanPageState extends State<HandymanPage> {
  late List<UserModel> all;
  Map<String, List<ReportModel>> subAdministrativeArea = {};

  void fetchData() async {
    print("fetchData");
    List<ReportModel> reports = await ReportController().getAllReports();
    Map<String, List<ReportModel>> map = {};

    for (var elem in reports) {
      if (elem.subAdministrativeArea.isEmpty) {
        if (map.containsKey("unknown")) {
          map["unknown"]!.add(elem);
        } else {
          map["unknown"] = [elem];
        }
      } else if (map.containsKey(elem.subAdministrativeArea)) {
        map[elem.subAdministrativeArea]!.add(elem);
      } else {
        map[elem.subAdministrativeArea] = [elem];
      }
    }

    List<String> keys = map.keys.toList();
    keys.sort();

    if (mounted) {
      setState(() {
        for (var key in keys) {
          subAdministrativeArea[key] = map[key]!;
        }
      });
    }
  }

  List<Widget> generateKeyButton(Map<String, List<ReportModel>> map) {
    // fetchData();
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
    List<Widget> addressSubAdministrativeArea =
        generateKeyButton(subAdministrativeArea);
    Widget addressSubAdministrativeArea2 = SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: addressSubAdministrativeArea.length,
        itemBuilder: (context, index) {
          return addressSubAdministrativeArea[index];
        },
      ),
    );

    List<Widget> list = [
      blackButton(
        context: context,
        text: "fetch data",
        onTap: (_) => fetchData(),
      ),
      const SizedBox(height: 15),
      blackButton(
        context: context,
        text: "download csv",
        onTap: (_) => fetchData(),
      ),
      const SizedBox(height: 25),
      const Divider(),
      const SizedBox(height: 25),
      addressSubAdministrativeArea2,
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return list[index];
          },
        ),
      ),
    );
  }
}
