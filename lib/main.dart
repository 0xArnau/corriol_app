import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:corriol_app/generated/l10n.dart';
import 'package:corriol_app/l10n/l10n.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:corriol_app/providers/report_provider.dart';
import 'package:corriol_app/providers/user_provider.dart';
import 'package:corriol_app/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<ReportProvider>(create: (_) => ReportProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchGpsInfo();
      Provider.of<UserProvider>(context, listen: false).fetchLangInfo();
      Provider.of<UserProvider>(context, listen: false).fetchMobileDataInfo();
      Provider.of<UserProvider>(context, listen: false)
          .fetchInternetConnectionInfo();
      Provider.of<UserProvider>(context, listen: false)
          .fetchInternetConnectionStatus();
    });

    // Provider.of<ReportProvider>(context, listen: false).fetchAllReports(
    //   context,
    //   Provider.of<UserProvider>(context, listen: false).preferences.mobileData,
    // );

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      Provider.of<UserProvider>(context, listen: false)
          .setInternetConnectionStatus(result);
    });

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
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
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
