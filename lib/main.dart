import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/l10n/l10n.dart';
import 'package:corriol_app/widget_tree.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corriol APP',
      theme: ThemeData(
        primarySwatch: kPrimaryBlue,
        useMaterial3: true,
      ),
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const WidgetTree(),
    );
  }
}
