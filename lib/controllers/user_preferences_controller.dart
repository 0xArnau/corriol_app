import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class that provides methods for managing user preferences using [shared_preferences].
class UserPreferencesController {
  /// Instance of [shared_preferences] for handling user preferences.
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  /// Sets the selected language to [lang] in shared preferences.
  static Future<void> setPrefsLang(Locale lang) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('lang', lang.toString());
  }

  /// Sets the GPS preference to [value] in shared preferences.
  static Future<void> setPrefsGps(bool value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('gps', value);
  }

  /// Sets the mobile data preference to [value] in shared preferences.
  static Future<void> setPrefsMobileData(bool value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('mobile_data', value);
  }

  /// Retrieves the selected language from shared preferences or `null` if there is no stored preference.
  static Future<String> getPrefsLang() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('lang') ??
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  }

  /// Retrieves the GPS preference from shared preferences or `null` if there is no stored preference.
  static Future<bool> getPrefsGps() async {
    final SharedPreferences prefs = await _prefs;
    final location = Permission.location.isGranted;
    final locationAlways = Permission.locationAlways.isGranted;
    final locationWhenInUse = Permission.locationWhenInUse.isGranted;

    final permissionStatus = await Future.wait([
      location,
      locationAlways,
      locationWhenInUse,
    ]);

    if (prefs.getBool('gps') != null && prefs.getBool('gps')! == true) {
      prefs.setBool('gps', permissionStatus.any((status) => status));
    }

    return prefs.getBool('gps') ?? permissionStatus.any((status) => status);
  }

  /// Retrieves the mobile data preference from shared preferences or `null` if there is no stored preference.
  static Future<bool> getPrefsMobileData() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('mobile_data') ?? true;
  }

  /// Retrieves if the device has internet connection
  static Future<bool> getInternetConnectionStatus(
      {ConnectivityResult? connectivityResult,
      required bool mobileData}) async {
    connectivityResult ??= await (Connectivity().checkConnectivity());
    final bool internetConnection;

    if (connectivityResult == ConnectivityResult.mobile && mobileData) {
      internetConnection = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      internetConnection = true;
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      internetConnection = true;
    } else if (connectivityResult == ConnectivityResult.vpn) {
      internetConnection = true;
    } else if (connectivityResult == ConnectivityResult.bluetooth) {
      internetConnection = false;
    } else if (connectivityResult == ConnectivityResult.other) {
      internetConnection = false;
    } else /* (connectivityResult == ConnectivityResult.none) */ {
      internetConnection = false;
    }

    return internetConnection;
  }

  /// Retrieves the [UserPreferencesModel] from shared preferences with default values.
  static Future<UserPreferencesModel> getUserPreferencesModel() async {
    final String lang = await getPrefsLang();
    final bool mobileData = await getPrefsMobileData();
    final bool gps = await getPrefsGps();

    return UserPreferencesModel(
      lang: Locale(lang),
      mobileData: mobileData,
      gps: gps,
    );
  }
}
