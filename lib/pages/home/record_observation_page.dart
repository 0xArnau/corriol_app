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
  int? _countFemales;
  int? _countMales;
  int? _countUndetermined;
  int? _countChickens;
  int? _countCats;
  int? _countDogs;
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
                    itemsList: [
                      AppLocalizations.of(context)
                          .screen1_3_Button_Select_Specie_Camanegre,
                      AppLocalizations.of(context)
                          .screen1_3_Button_Select_Specie_Petit,
                    ],
                    hint: AppLocalizations.of(context)
                        .screen1_3_Button_Select_Specie,
                    onChanged: (value) {
                      setState(() {
                        _especie = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  // Females
                  CounterButtonWidget(
                    hint: AppLocalizations.of(context).screen1_3_Button_Females,
                    image: const AssetImage(
                        'assets/images/Screen-1_3/femelles.png'),
                    onChanged: (value) {
                      setState(() {
                        _countFemales = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  // Males
                  CounterButtonWidget(
                    hint: AppLocalizations.of(context).screen1_3_Button_Males,
                    image: const AssetImage(
                        'assets/images/Screen-1_3/mescles.png'),
                    onChanged: (value) {
                      setState(() {
                        _countMales = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  // Undetermined
                  CounterButtonWidget(
                    hint: AppLocalizations.of(context)
                        .screen1_3_Button_Undetermined,
                    image: const AssetImage(
                        'assets/images/Screen-1_3/indeterminat.png'),
                    onChanged: (value) {
                      setState(() {
                        _countUndetermined = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  // Chickens
                  CounterButtonWidget(
                    hint:
                        AppLocalizations.of(context).screen1_3_Button_Chickens,
                    image:
                        const AssetImage('assets/images/Screen-1_3/polls.png'),
                    onChanged: (value) {
                      setState(() {
                        _countChickens = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  // Cats
                  CounterButtonWidget(
                    hint: AppLocalizations.of(context).screen1_3_Button_Cats,
                    image:
                        const AssetImage('assets/images/Screen-1_3/gats.png'),
                    onChanged: (value) {
                      setState(() {
                        _countCats = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  // Dogs
                  CounterButtonWidget(
                    hint: AppLocalizations.of(context).screen1_3_Button_Dogs,
                    image:
                        const AssetImage('assets/images/Screen-1_3/gossos.png'),
                    onChanged: (value) {
                      setState(() {
                        _countDogs = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
