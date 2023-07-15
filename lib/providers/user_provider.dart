import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/controllers/user_preferences_controller.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late UserModel? _user;
  late UserPreferencesModel _preferences;

  get user => _user;
  get preferences => _preferences;

  UserProvider() {
    _user = null;
    _preferences =
        UserPreferencesModel(lang: Locale(ui.window.locale.languageCode));

    print("UserProvider(){}");
  }

  Future<void> fetchUserInfo() async {
    _user = await AuthController().getUserInformation();
    notifyListeners();
    print(_user);
  }

  void fetchMobileDataInfo() {
    final mobileData = UserPreferencesController.getPrefsMobileData as bool?;
    _preferences.mobileData = mobileData ?? false;
    notifyListeners();
    print(_preferences.mobileData);
  }

  void fetchGpsInfo() {
    final gps = UserPreferencesController.getPrefsGps as bool?;
    _preferences.gps = gps ?? false;
    notifyListeners();
    print(_preferences.gps);
  }

  void fetchLangInfo() {
    final lang = UserPreferencesController.getPrefsLang as String?;
    _preferences.lang = Locale(lang ?? ui.window.locale.languageCode);
    notifyListeners();
    print(_preferences.lang);
  }

  void setMobileDataInfo(bool mobileData) {
    UserPreferencesController.setPrefsMobileData(mobileData);
    _preferences.mobileData = mobileData;
    notifyListeners();
    print(_preferences.mobileData);
  }

  void setGpsInfo(bool gps) {
    UserPreferencesController.setPrefsGps(gps);
    _preferences.gps = gps;
    notifyListeners();
    print(_preferences.gps);
  }

  void setLangInfo(Locale lang) {
    UserPreferencesController.setPrefsLang(lang);
    _preferences.lang = lang;
    notifyListeners();
    print(_preferences.lang);
  }
}
