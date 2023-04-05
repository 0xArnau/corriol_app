import 'dart:io';
import 'dart:convert';

import 'package:corriol_app/classes/record_observations_class.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/core/notifiers.dart';
import 'package:corriol_app/widgets/buttons/counter_button_widget.dart';
import 'package:corriol_app/widgets/buttons/dropdown_button_widget.dart';
import 'package:corriol_app/widgets/buttons/map_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:corriol_app/classes/file_io_class.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RecordObservationPage extends StatefulWidget {
  const RecordObservationPage({super.key});

  @override
  State<RecordObservationPage> createState() => _RecordObservationPageState();
}

class _RecordObservationPageState extends State<RecordObservationPage> {
  RecordObservationClass fields = RecordObservationClass(
    coordenates: const LatLng(0, 0),
    species: 'species',
    females: 0,
    males: 0,
    undetermined: 0,
    chickens: 0,
    cats: 0,
    dogs: 0,
  );

  FileIoClass fileClass = FileIoClass(fileName: 'test.txt');

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
                  fields.species = value;
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
                  fields.females = value;
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
                  fields.males = value;
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
                  fields.undetermined = value;
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
                  fields.chickens = value;
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
                  fields.cats = value;
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
                  fields.dogs = value;
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
                  fileClass.writeContent(jsonEncode(fields.toJson()));
                  // Show the Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Saving information'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  Navigator.pop(context);
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
