import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/widgets/buttons/counter_button_widget.dart';
import 'package:corriol_app/widgets/buttons/dropdown_button_widget.dart';
import 'package:corriol_app/widgets/buttons/map_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class RecordObservationPage extends StatefulWidget {
  const RecordObservationPage({super.key});

  @override
  State<RecordObservationPage> createState() => _RecordObservationPageState();
}

class _RecordObservationPageState extends State<RecordObservationPage> {
  List _itemsList = [
    "Corriol A",
    "Corriol B",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).recordObservation,
          style: kTextStylePageTitle,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kDouble25),
          child: Center(
            child: Column(
              children: [
                // Map
                const MapButtonWidget(),
                const SizedBox(height: 15),
                // Especie
                DropdownButtonWidget(itemsList: _itemsList, hint: "Espècie"),
                const SizedBox(height: 15),
                // Femelles
                const CounterButtonWidget(hint: "# Femelles"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
