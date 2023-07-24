import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/controllers/geolocation_controller.dart';
import 'package:corriol_app/controllers/report_controller.dart';
import 'package:corriol_app/controllers/user_preferences_controller.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserProvider extends ChangeNotifier {
  late UserModel? _user;
  late UserPreferencesModel _preferences;
  late LatLng _position;

  Map<String, List<ReportModel>> subAdministrativeArea = {};

  get user => _user;
  get preferences => _preferences;
  get position => _position;

  UserProvider() {
    _user = null;
    _preferences = UserPreferencesModel();
    _position = const LatLng(41.8205, 1.8401); // Catalunya

    print(
        "Constructor UserProvider() ${this.preferences.toString()}, {$_position}");

    init();
  }

  Future<void> init() async {
    // Obtener las preferencias asincrónicas
    _preferences = await UserPreferencesController.getUserPreferencesModel();

    // Notificar a los listeners que las preferencias han cambiado
    notifyListeners();

    // Continuar con cualquier otra inicialización necesaria
    fetchPosition();
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

  void fetchReportDataSubAdministrativeArea() async {
    final List<ReportModel> reports = await ReportController().getAllReports();
    Map<String, List<ReportModel>> map = {};

    for (var elem in reports) {
      if (elem.subAdministrativeArea.isEmpty) {
        if (map.containsKey("unknown")) {
          map["unknown"]!.add(elem);
        } else {
          map["unknown"] = [elem];
        }
      } else if (map.containsKey(elem.subAdministrativeArea)) {
        map[elem.subAdministrativeArea]!.add(elem);
      } else {
        map[elem.subAdministrativeArea] = [elem];
      }
    }

    List<String> keys = map.keys.toList();
    keys.sort();

    subAdministrativeArea = {};

    for (var key in keys) {
      subAdministrativeArea[key] = map[key]!;
    }

    notifyListeners();
    print("reports");
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
