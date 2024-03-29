import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/pages/home/contact_page.dart';
import 'package:corriol_app/pages/home/corriol_page.dart';
import 'package:corriol_app/pages/home/my_records_page.dart';
import 'package:corriol_app/pages/home/record_observation_page.dart';
import 'package:corriol_app/utils/constants.dart';
import 'package:corriol_app/widgets/card_widget.dart';
import 'package:flutter/material.dart';

/// The home page of the Corriol App.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  imagePath: 'assets/images/home/1_1-coneix-al-corriol.png',
                  text: S.current.meetKentishPlover,
                  background: kColorScreenCorriol,
                  foreground: Colors.black,
                  page: const CorriolPage(),
                ),
                CardWidget(
                  imagePath: 'assets/images/home/1_6-contacta.png',
                  text: S.current.contact,
                  background: kColorScreenContact,
                  foreground: Colors.black,
                  page: ContactPage(),
                ),
                CardWidget(
                  imagePath: 'assets/images/home/1_3-anotar-observacio.png',
                  text: S.current.recordObservation,
                  background: kColorScreenReport,
                  foreground: Colors.black,
                  page: const RecordObservationPage(),
                ),
                CardWidget(
                  imagePath: 'assets/images/home/1_4-registres.png',
                  text: S.current.myRecords,
                  background: kColorScreenMyReports,
                  foreground: Colors.black,
                  page: const MyRecordsPage(),
                ),
              ],
            ),
            const SizedBox(height: kDoublePaddingGridViewText),
            Text(
              S.current.warningText112,
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
                color: kColorText,
              ),
            ),
            const SizedBox(height: kDoublePaddingGridViewText),
            const Image(
              image: AssetImage('assets/images/GEPEC_EdC_OFICIAL.png'),
            ),
          ],
        ),
      ),
    );
  }
}
