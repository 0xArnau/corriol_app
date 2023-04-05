import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/core/notifiers.dart';
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
  int _countFemales = 0;
  int _countMales = 0;
  int _countUndetermined = 0;
  int _countChickens = 0;
  int _countCats = 0;
  int _countDogs = 0;
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
      body: Padding(
        padding: const EdgeInsets.all(kDouble25),
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
              hint: AppLocalizations.of(context).screen1_3_Button_Select_Specie,
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
              image: const AssetImage('assets/images/Screen-1_3/femelles.png'),
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
              image: const AssetImage('assets/images/Screen-1_3/mescles.png'),
              onChanged: (value) {
                setState(() {
                  _countMales = value;
                });
              },
            ),
            const SizedBox(height: 15),
            // Undetermined
            CounterButtonWidget(
              hint: AppLocalizations.of(context).screen1_3_Button_Undetermined,
              image:
                  const AssetImage('assets/images/Screen-1_3/indeterminat.png'),
              onChanged: (value) {
                setState(() {
                  _countUndetermined = value;
                });
              },
            ),
            const SizedBox(height: 15),
            // Chickens
            CounterButtonWidget(
              hint: AppLocalizations.of(context).screen1_3_Button_Chickens,
              image: const AssetImage('assets/images/Screen-1_3/polls.png'),
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
              image: const AssetImage('assets/images/Screen-1_3/gats.png'),
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
              image: const AssetImage('assets/images/Screen-1_3/gossos.png'),
              onChanged: (value) {
                setState(() {
                  _countDogs = value;
                });
              },
            ),
            const SizedBox(height: 15),
            // Submit
            const Spacer(),
            SizedBox(
              height: null,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                onPressed: () {
                  // Show the Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "${AppLocalizations.of(context).screen1_3_Button_Select_Specie}: $_especie\n${AppLocalizations.of(context).screen1_3_Button_Females}: $_countFemales\n${AppLocalizations.of(context).screen1_3_Button_Males}: $_countMales\n${AppLocalizations.of(context).screen1_3_Button_Undetermined}: $_countUndetermined\n${AppLocalizations.of(context).screen1_3_Button_Chickens}: $_countChickens\n${AppLocalizations.of(context).screen1_3_Button_Cats}: $_countCats\n${AppLocalizations.of(context).screen1_3_Button_Dogs}: $_countDogs"),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
                child: const Text('Submit'),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
