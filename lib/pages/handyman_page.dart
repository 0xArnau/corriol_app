import 'package:corriol_app/controllers/report_controller.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/widgets/buttons/black_button_widget.dart';
import 'package:flutter/material.dart';

class HandymanPage extends StatefulWidget {
  const HandymanPage({super.key});

  @override
  State<HandymanPage> createState() => _HandymanPageState();
}

class _HandymanPageState extends State<HandymanPage> {
  late List<UserModel> all;
  Map<String, List<ReportModel>> administrativeArea = {};
  Map<String, List<ReportModel>> subAdministrativeArea = {};
  Map<String, List<ReportModel>> locality = {};

  void fetchData() async {
    print("fetchData");
    List<ReportModel> reports = await ReportController().getAllReports();
    setState(() {
      for (var elem in reports) {
        if (elem.administrativeArea.isEmpty) {
          if (administrativeArea.containsKey("unknown")) {
            administrativeArea["unknown"]!.add(elem);
          } else {
            administrativeArea["unknown"] = [elem];
          }
        } else if (administrativeArea.containsKey(elem.administrativeArea)) {
          administrativeArea[elem.administrativeArea]!.add(elem);
        } else {
          administrativeArea[elem.administrativeArea] = [elem];
        }

        if (elem.subAdministrativeArea.isEmpty) {
          if (subAdministrativeArea.containsKey("unknown")) {
            subAdministrativeArea["unknown"]!.add(elem);
          } else {
            subAdministrativeArea["unknown"] = [elem];
          }
        } else if (subAdministrativeArea
            .containsKey(elem.subAdministrativeArea)) {
          subAdministrativeArea[elem.subAdministrativeArea]!.add(elem);
        } else {
          subAdministrativeArea[elem.subAdministrativeArea] = [elem];
        }

        if (elem.locality.isEmpty) {
          if (locality.containsKey("unknown")) {
            locality["unknown"]!.add(elem);
          } else {
            locality["unknown"] = [elem];
          }
        } else if (locality.containsKey(elem.locality)) {
          locality[elem.locality]!.add(elem);
        } else {
          locality[elem.locality] = [elem];
        }
      }
    });
  }

  List<Widget> generateKeyButton(Map<String, List<ReportModel>> map) {
    // fetchData();
    List<Widget> widgets = [];
    map.forEach((key, value) {
      widgets.add(Text(key));
    });

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      blackButton(
        context: context,
        text: "fetch data",
        onTap: (_) => fetchData(),
      ),
      const SizedBox(height: 25),
      blackButton(
        context: context,
        text: "download csv",
        onTap: (_) => fetchData(),
      ),
      const SizedBox(height: 25),
      blackButton(
        context: context,
        text: "??",
        onTap: (_) => fetchData(),
      ),
      const SizedBox(height: 25),
      blackButton(
        context: context,
        text: "??",
        onTap: (_) => fetchData(),
      ),
      const SizedBox(height: 25),
      const SizedBox(height: 50),
    ];

    var address = generateKeyButton(administrativeArea);
    var address2 = SizedBox(
      height: 200, // Define la altura que desees
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: address.length,
        itemBuilder: (context, index) {
          return address[index];
        },
      ),
    );

    list.add(const Text("administrativeArea"));
    list.add(const SizedBox(height: 15));
    list.add(address2);

    address = generateKeyButton(subAdministrativeArea);
    address2 = SizedBox(
      height: 200, // Define la altura que desees
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: address.length,
        itemBuilder: (context, index) {
          return address[index];
        },
      ),
    );

    list.add(const Text("subAdministrativeArea"));
    list.add(const SizedBox(height: 15));
    list.add(address2);

    address = generateKeyButton(locality);
    address2 = SizedBox(
      height: 200, // Define la altura que desees
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: address.length,
        itemBuilder: (context, index) {
          return address[index];
        },
      ),
    );

    list.add(const Text("locality"));
    list.add(const SizedBox(height: 15));
    list.add(address2);

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
