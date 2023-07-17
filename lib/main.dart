import 'package:corriol_app/core/constants.dart';
import 'package:corriol_app/l10n/l10n.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:corriol_app/splash.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final preferences = userProvider.preferences as UserPreferencesModel;
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
            locale: preferences.lang, // Use the lang from UserPreferencesModel
          );
        },
      ),
    );
  }
}
