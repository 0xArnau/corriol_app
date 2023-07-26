import 'package:corriol_app/controllers/geolocation_controller.dart';
import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/controllers/report_controller.dart';
import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:corriol_app/widgets/buttons/counter_button_widget.dart';
import 'package:corriol_app/widgets/buttons/dropdown_button_widget.dart';
import 'package:corriol_app/widgets/buttons/map_button_widget.dart';
import 'package:corriol_app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class RecordObservationPage extends StatefulWidget {
  const RecordObservationPage({super.key});

  @override
  State<RecordObservationPage> createState() => _RecordObservationPageState();
}

class _RecordObservationPageState extends State<RecordObservationPage> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).fetchPosition();
    super.initState();
  }

  ReportModel fields = ReportModel(
    createdAt: DateTime.now().toIso8601String(),
    createdBy: AuthController().currentUser!.email!,
    coordenates: const LatLng(0, 0),
    species: Species.corriolCamanegre,
    females: 0,
    males: 0,
    undetermined: 0,
    chickens: 0,
    cats: 0,
    dogs: 0,
    administrativeArea: "none",
    subAdministrativeArea: "none",
    locality: "none",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.recordObservation,
          style: kTextStylePageTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDouble25),
        child: Consumer<UserProvider>(
          builder: (context, value, child) {
            final preferences = value.preferences as UserPreferencesModel;
            return ListView.builder(
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
                          S.current.screen1_3_Button_Select_Specie_Camanegre,
                          S.current.screen1_3_Button_Select_Specie_Petit,
                        ],
                        hint: S.current.screen1_3_Button_Select_Specie,
                        onChanged: (value) {
                          if (mounted) {
                            setState(() {
                              fields.species = SpeciesExtension.valueOf(value);
                            });
                          }
                        });
                  case 3:
                    return const SizedBox(height: 15);
                  case 4:
                    return CounterButtonWidget(
                      hint: S.current.screen1_3_Button_Females,
                      image: const AssetImage(
                          'assets/images/Screen-1_3/femelles.png'),
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
                      hint: S.current.screen1_3_Button_Males,
                      image: const AssetImage(
                          'assets/images/Screen-1_3/mescles.png'),
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
                      hint: S.current.screen1_3_Button_Undetermined,
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
                      hint: S.current.screen1_3_Button_Chickens,
                      image: const AssetImage(
                          'assets/images/Screen-1_3/polls.png'),
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
                      hint: S.current.screen1_3_Button_Cats,
                      image:
                          const AssetImage('assets/images/Screen-1_3/gats.png'),
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
                      hint: S.current.screen1_3_Button_Dogs,
                      image: const AssetImage(
                          'assets/images/Screen-1_3/gossos.png'),
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
                  case 16:
                    return SizedBox(
                      height: null,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          saveReport(preferences.mobileData);
                        },
                        child: Text(S.current.submit),
                      ),
                    );
                }
                return null;
              },
            );
          },
        ),
      ),
    );
  }

  void saveReport(bool mobileData) async {
    if (fields.cats == 0 &&
        fields.dogs == 0 &&
        fields.chickens == 0 &&
        fields.undetermined == 0 &&
        fields.females == 0 &&
        fields.males == 0) {
      snackbarError(context, S.current.errorEmptyFields);

      return;
    }
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);

    try {
      List<String> address =
          await GeolocationController().updateAddress(provider);

      fields.administrativeArea = address[0];
      fields.subAdministrativeArea = address[1];
      fields.locality = address[2];

      fields.coordenates = provider.position;
    } catch (e) {
      Logger().e(e);
    } finally {
      if (fields.administrativeArea.isEmpty &&
          fields.subAdministrativeArea.isEmpty &&
          fields.locality.isEmpty) {
        snackbarError(context, S.current.errorEmptyFields);
      } else {
        ReportController().saveReport(fields, mobileData);
        snackbarInfo(context, S.current.saveInformation);
        Navigator.pop(context);
      }
    }
  }
}
