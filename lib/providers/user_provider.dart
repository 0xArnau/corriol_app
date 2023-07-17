import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/controllers/geolocation_controller.dart';
import 'package:corriol_app/controllers/user_preferences_controller.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserProvider extends ChangeNotifier {
  late UserModel? _user;
  late UserPreferencesModel _preferences;
  late LatLng _position;

  get user => _user;
  get preferences => _preferences;
  get position => _position;

  UserProvider() {
    _user = null;
    _preferences = UserPreferencesModel(
      lang: Locale(ui.window.locale.languageCode),
      gps: GeolocationController().checkGpsStatus(),
    );
    _position = const LatLng(41.8205, 1.8401); // Catalunya

    print("Constructor UserProvider(){}");
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

  void fetchPosition() async {
    print("fetchPosition");
    final position = await GeolocationController().getCurrentLocation(this);
    _position = LatLng(position.latitude, position.longitude);
    notifyListeners();
    print(_position);
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

  void setPosition(LatLng position) {
    print("setPosition");
    _position = position;
    notifyListeners();
    print(_position);
  }
}
