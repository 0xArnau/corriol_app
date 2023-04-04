import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/core/notifiers.dart';
import 'package:corriol_app/widgets/buttons/counter_button_widget.dart';
import 'package:corriol_app/widgets/buttons/dropdown_button_widget.dart';
import 'package:corriol_app/widgets/buttons/map_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RecordObservationPage extends StatefulWidget {
  const RecordObservationPage({super.key});

  @override
  State<RecordObservationPage> createState() => _RecordObservationPageState();
}

class _RecordObservationPageState extends State<RecordObservationPage> {
  final List _itemsList = [
    "Corriol A",
    "Corriol B",
  ];

  int? _countFemelles;
  String? _especie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).recordObservation,
          style: kTextStylePageTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(kDouble25),
            child: Center(
              child: Column(
                children: [
                  // Map
                  const MapButtonWidget(),
                  const SizedBox(height: 15),
                  // Especie
                  DropdownButtonWidget(
                    itemsList: _itemsList,
                    hint: "Espècie",
                    onChanged: (value) {
                      setState(() {
                        _especie = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  // Femelles
                  CounterButtonWidget(
                    hint: "# Femelles",
                    onChanged: (value) {
                      setState(() {
                        _countFemelles = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  //
                  Text(_countFemelles.toString()),
                  _especie != null ? Text(_especie!) : const Text('null'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
