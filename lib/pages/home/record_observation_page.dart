import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:math';

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
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

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

  late StreamSubscription<ConnectivityResult> subscription;
  late bool saveInformation2DB;

  @override
  void initState() {
    super.initState();
    // TODO: decide wether to move this to home page, widget_tree or somewhere else
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        // To simulate there is no internet connection
        // TODO: remove the next line in production
        result = ConnectivityResult.none;
        if (result == ConnectivityResult.wifi) {
          // internet connection with WiFi
          // send the information to the database
          print('internet connection: wifi');
          saveInformation2DB = true;
        } else {
          // some type of internet connection or without internet connection
          // check this for more information: https://pub.dev/documentation/connectivity_plus/latest/
          // TODO: decide which types are allowed to send information or not
          // Don't send the information, save it locally
          print("internet connection status: ${result}");
          saveInformation2DB = false;
        }
      },
    );
  }

  // Be sure to cancel subscription after you are done
  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

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
        child: ListView.builder(
          itemCount: 17,
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return const MapButtonWidget();
              case 1:
                return const SizedBox(height: 15);
              case 2:
                return DropdownButtonWidget(
                    itemsList: [
                      AppLocalizations.of(context)
                          .screen1_3_Button_Select_Specie_Camanegre,
                      AppLocalizations.of(context)
                          .screen1_3_Button_Select_Specie_Petit,
                    ],
                    hint: AppLocalizations.of(context)
                        .screen1_3_Button_Select_Specie,
                    onChanged: (value) {
                      if (mounted) {
                        setState(() {
                          fields.species = value;
                        });
                      }
                    });
              case 3:
                return const SizedBox(height: 15);
              case 4:
                return CounterButtonWidget(
                  hint: AppLocalizations.of(context).screen1_3_Button_Females,
                  image:
                      const AssetImage('assets/images/Screen-1_3/femelles.png'),
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        fields.females = value;
                      });
                    }
                  },
                );
              case 5:
                return const SizedBox(height: 15);
              case 6:
                return CounterButtonWidget(
                  hint: AppLocalizations.of(context).screen1_3_Button_Males,
                  image:
                      const AssetImage('assets/images/Screen-1_3/mescles.png'),
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        fields.males = value;
                      });
                    }
                  },
                );
              case 7:
                return const SizedBox(height: 15);
              case 8:
                return CounterButtonWidget(
                  hint: AppLocalizations.of(context)
                      .screen1_3_Button_Undetermined,
                  image: const AssetImage(
                      'assets/images/Screen-1_3/indeterminat.png'),
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        fields.undetermined = value;
                      });
                    }
                  },
                );
              case 9:
                return const SizedBox(height: 15);
              case 10:
                return CounterButtonWidget(
                  hint: AppLocalizations.of(context).screen1_3_Button_Chickens,
                  image: const AssetImage('assets/images/Screen-1_3/polls.png'),
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        fields.chickens = value;
                      });
                    }
                  },
                );
              case 11:
                return const SizedBox(height: 15);
              case 12:
                return CounterButtonWidget(
                  hint: AppLocalizations.of(context).screen1_3_Button_Cats,
                  image: const AssetImage('assets/images/Screen-1_3/gats.png'),
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        fields.cats = value;
                      });
                    }
                  },
                );
              case 13:
                return const SizedBox(height: 15);
              case 14:
                return CounterButtonWidget(
                  hint: AppLocalizations.of(context).screen1_3_Button_Dogs,
                  image:
                      const AssetImage('assets/images/Screen-1_3/gossos.png'),
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        fields.dogs = value;
                      });
                    }
                  },
                );
              case 15:
                return const SizedBox(height: 15);
              // case 16:
              //   return const Spacer();
              case 16:
                return SizedBox(
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
                      saveReport();
                    },
                    child: const Text('Submit'),
                  ),
                );
              // case 18:
              //   return const Spacer();
            }
            return null;
          },
        ),
      ),
    );
  }

  void saveReport() {
    saveInformation2DB
        ? reportsFile.writeContent(jsonEncode(fields.toJson()))
        : reportsWithoutConnectionfile
            .writeContent(jsonEncode(fields.toJson()));
    // Show the Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).saveInformation),
        duration: const Duration(seconds: 3),
      ),
    );
    Navigator.pop(context);
  }
}
