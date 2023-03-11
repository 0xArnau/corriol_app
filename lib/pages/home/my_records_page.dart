import 'package:corriol_app/core/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MyRecordsPage extends StatelessWidget {
  const MyRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).myRecords,
          style: kTextStylePageTitle,
        ),
      ),
    );
  }
}
