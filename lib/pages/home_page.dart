import 'package:corriol_app/classes/geolocation_class.dart';
import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/core/notifiers.dart';
import 'package:corriol_app/pages/home/contact_page.dart';
import 'package:corriol_app/pages/home/corriol_page.dart';
import 'package:corriol_app/pages/home/my_records_page.dart';
import 'package:corriol_app/pages/home/record_observation_page.dart';
import 'package:corriol_app/widgets/card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isGpsOnNotifier,
      builder: (context, isGpsOn, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    CardWidget(
                      imagePath:
                          'assets/images/home/1_1-coneix-al-corriol.png', // TODO: Changes this to a valid image path
                      text: AppLocalizations.of(context).meetKentishPlover,
                      background: kColorRedCard,
                      foreground: Colors.black,
                      page: const CorriolPage(),
                    ),
                    CardWidget(
                      imagePath:
                          'assets/images/home/1_6-contacta.png', // TODO: Changes this to a valid image path
                      text: AppLocalizations.of(context).contact,
                      background: kColorPurpleCard,
                      foreground: Colors.black,
                      page: ContactPage(),
                    ),
                    CardWidget(
                      imagePath:
                          'assets/images/home/1_3-anotar-observacio.png', // TODO: Changes this to a valid image path
                      text: AppLocalizations.of(context).recordObservation,
                      background: kColorGreenCard,
                      foreground: Colors.black,
                      page: const RecordObservationPage(),
                    ),
                    CardWidget(
                      imagePath:
                          'assets/images/home/1_4-registres.png', // TODO: Changes this to a valid image path
                      text: AppLocalizations.of(context).myRecords,
                      background: kColorYellowCard,
                      foreground: Colors.black,
                      page: const MyRecordsPage(),
                    ),
                  ],
                ),
                const SizedBox(height: kDoublePaddingGridViewText),
                Text(
                  AppLocalizations.of(context).warningText112,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kColorPrimaryGrey,
                  ),
                ),
                const Text(
                  '112',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: kColorPrimaryBlue,
                  ),
                ),
                // TODO: Add GEPEC & EdC Logos
                const Image(
                  image: AssetImage('assets/images/GEPEC_EdC_OFICIAL.png'),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              isGpsOnNotifier.value
                  ? GeolocationClass().disableLocationPermission()
                  : GeolocationClass().enableLocationPermission();
            },
            child: ValueListenableBuilder(
              valueListenable: isGpsOnNotifier,
              builder: (context, isGpsOn, child) {
                return isGpsOn
                    ? const Icon(Icons.gps_fixed)
                    : const Icon(Icons.gps_off);
              },
            ),
          ),
        );
      },
    );
  }
}
