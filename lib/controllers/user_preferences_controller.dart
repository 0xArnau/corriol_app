import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class UserPreferencesController {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<void> setPrefsLang(Locale lang) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('lang', lang.toString());
  }

  static Future<void> setPrefsGps(bool value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('gps', value);
  }

  static Future<void> setPrefsMobileData(bool value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('mobile_data', value);
  }

  static Future<String?> getPrefsLang() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('lang');
  }

  static Future<bool?> getPrefsGps() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('gps');
  }

  static Future<bool?> getPrefsMobileData() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('mobile_data');
  }

  static Future<UserPreferencesModel> getUserPreferencesModel() async {
    final SharedPreferences prefs = await _prefs;
    final String? lang = prefs.getString("lang");
    final bool? mobileData = prefs.getBool("mobile_data");
    final bool? gps = prefs.getBool("gps");

    return UserPreferencesModel(
      lang: Locale(lang ?? ui.window.locale.languageCode),
      mobileData: mobileData ?? true,
      gps: gps ?? true,
    );
  }
}
