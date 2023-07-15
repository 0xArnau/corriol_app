import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
