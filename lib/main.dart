import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/l10n/l10n.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:corriol_app/splash.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserProvider provider = UserProvider();

  @override
  void initState() {
    provider.fetchGpsInfo();
    provider.fetchLangInfo();
    provider.fetchMobileDataInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => provider,
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final preferences = userProvider.preferences as UserPreferencesModel;
          return MaterialApp(
            title: 'Corriol APP',
            theme: ThemeData(
              useMaterial3: true,
            ),
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              S.delegate,
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
