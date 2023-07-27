import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/controllers/geolocation_controller.dart';
import 'package:corriol_app/controllers/report_controller.dart';
import 'package:corriol_app/controllers/user_preferences_controller.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserProvider extends ChangeNotifier {
  late UserModel? _user;
  late UserPreferencesModel _preferences;
  late LatLng _position;

  Map<String, List<ReportModel>> locality = {};

  get user => _user;
  get preferences => _preferences;
  get position => _position;

  UserProvider() {
    _user = null;
    _preferences = UserPreferencesModel();
    _position = const LatLng(41.8205, 1.8401); // Catalunya

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
  }

  void fetchMobileDataInfo() async {
    bool? mobileData = await UserPreferencesController.getPrefsMobileData();
    _preferences.mobileData = mobileData ?? false;
    notifyListeners();
  }

  void fetchGpsInfo() async {
    bool? gpsValue = await UserPreferencesController.getPrefsGps();
    _preferences.gps = gpsValue ?? false;
    notifyListeners();
  }

  void fetchLangInfo() async {
    String? lang = await UserPreferencesController.getPrefsLang();
    _preferences.lang = Locale(
        lang ?? WidgetsBinding.instance.platformDispatcher.locale.languageCode);
    notifyListeners();
  }

  void fetchPosition() async {
    final position = await GeolocationController().getCurrentLocation(this);

    if (position == null) return;

    _position = LatLng(position.latitude, position.longitude);
    notifyListeners();
  }

  void fetchReportDatalocality() async {
    final List<ReportModel> reports = await ReportController().getAllReports();
    Map<String, List<ReportModel>> map = {};

    for (var elem in reports) {
      if (elem.locality.isEmpty) {
        if (map.containsKey("unknown")) {
          map["unknown"]!.add(elem);
        } else {
          map["unknown"] = [elem];
        }
      } else if (map.containsKey(elem.locality)) {
        map[elem.locality]!.add(elem);
      } else {
        map[elem.locality] = [elem];
      }
    }

    List<String> keys = map.keys.toList();
    keys.sort();

    locality = {};

    for (var key in keys) {
      locality[key] = map[key]!;
    }

    notifyListeners();
  }

  void setMobileDataInfo(bool mobileData) {
    UserPreferencesController.setPrefsMobileData(mobileData);
    _preferences.mobileData = mobileData;
    notifyListeners();
  }

  void setGpsInfo(bool gps) {
    UserPreferencesController.setPrefsGps(gps);
    _preferences.gps = gps;
    notifyListeners();
  }

  void setLangInfo(Locale lang) {
    UserPreferencesController.setPrefsLang(lang);
    _preferences.lang = lang;
    notifyListeners();
  }

  void setPosition(LatLng position) {
    _position = position;
    notifyListeners();
  }
}
