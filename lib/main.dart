import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/core/notifiers.dart';
import 'package:corriol_app/l10n/l10n.dart';
import 'package:corriol_app/splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String locale = ui.window.locale.languageCode;

  if (await cfg.fileExists()) {
    locale = await cfg.readcontent();
  }

  MyApp.languageCode = Locale(locale);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  static late final Locale languageCode;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: localeNotifier,
      builder: (context, locale, child) {
        return MaterialApp(
          title: 'Corriol APP',
          theme: ThemeData(
            primarySwatch: kColorPrimaryBlue,
            useMaterial3: true,
          ),
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: const Splash(),
          locale: locale,
        );
      },
    );
  }
}
