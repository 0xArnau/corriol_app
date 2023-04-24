import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
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
  userConfigNotifier.value.locale = Locale(ui.window.locale.languageCode);
  userConfigNotifier.value.loadConfig();

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
  late StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    super.initState();
    // TODO: decide wether to move this to home page, widget_tree or somewhere else
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        // To simulate there is no internet connection
        // TODO: remove the next line in production
        result = ConnectivityResult.none;
        if (result == ConnectivityResult.none) {
          isConnectedNotifier.value = true;
          print('no internet connection');
        } else if (result == ConnectivityResult.wifi) {
          // internet connection with WiFi
          // send the information to the database
          print('internet connection: wifi');
          isConnectedNotifier.value = true;
        } else {
          // some type of internet connection
          // check this for more information: https://pub.dev/documentation/connectivity_plus/latest/
          // TODO: decide which types are allowed to send information or not
          // Don't send the information, save it locally
          print("internet connection status: ${result}");
          isConnectedNotifier.value = false;
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
    print(userConfigNotifier.value.locale);
    return ValueListenableBuilder(
      valueListenable: userConfigNotifier,
      builder: (context, userConfig, child) {
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
          locale: userConfig.locale,
        );
      },
    );
  }
}
