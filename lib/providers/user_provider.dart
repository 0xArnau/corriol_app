import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/controllers/geolocation_controller.dart';
import 'package:corriol_app/controllers/report_controller.dart';
import 'package:corriol_app/controllers/user_preferences_controller.dart';
import 'package:corriol_app/models/report_model.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:corriol_app/models/user_preferences_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Class to manage the current user information
class UserProvider extends ChangeNotifier {
  /// The current user
  late UserModel? _user;

  /// The preferences of the current user
  late UserPreferencesModel _preferences;

  /// The current position or a position selected on the map
  late LatLng _position;

  /// Stores all the reports made by all users, the reports are grouped by locality
  Map<String, List<ReportModel>> locality = {};

  /// Return the [UserModel] instance of the current user or [null]
  get user => _user;

  /// Returns the [UserPreferencesModel] instance of the current user preferences, which contains: [UserPreferencesModel.lang], [UserPreferencesModel.mobileData] and [UserPreferencesModel.gps].
  get preferences => _preferences;

  /// Return the selected position coordinates ([LatLng])
  get position => _position;

  /// Constructor of the [UserProvider] class.
  UserProvider() {
    _user = null;
    _preferences = UserPreferencesModel();
    _position = const LatLng(41.8205, 1.8401); // Catalunya

    init();
  }

  /// Initialize the [UserModelPreferences].
  Future<void> init() async {
    _preferences = await UserPreferencesController.getUserPreferencesModel();
    notifyListeners();
    fetchPosition();
  }

  /// Fetches the [UserModel] info from the [AuthController.getUserInformation].
  Future<void> fetchUserInfo() async {
    _user = await AuthController().getUserInformation();
    notifyListeners();
  }

  /// Fetches the [UserPreferencesModel.mobileData] info from the [UserPreferencesController.getPrefsMobileData].
  void fetchMobileDataInfo() async {
    bool? mobileData = await UserPreferencesController.getPrefsMobileData();
    _preferences.mobileData = mobileData ?? false;
    notifyListeners();
  }

  /// Fetches the [UserPreferencesModel.gps] info from the [UserPreferencesController.getPrefsGps].
  void fetchGpsInfo() async {
    bool? gpsValue = await UserPreferencesController.getPrefsGps();
    _preferences.gps = gpsValue ?? false;
    notifyListeners();
  }

  /// Fetches the [UserPreferencesModel.lang] info from the [UserPreferencesController.getPrefsLang].
  void fetchLangInfo() async {
    String? lang = await UserPreferencesController.getPrefsLang();
    _preferences.lang = Locale(
        lang ?? WidgetsBinding.instance.platformDispatcher.locale.languageCode);
    notifyListeners();
  }

  /// Fetches the [_position] info from the [GeolocationController.getCurrentLocation].
  void fetchPosition() async {
    final position = await GeolocationController().getCurrentLocation(this);

    if (position == null) return;

    _position = LatLng(position.latitude, position.longitude);
    notifyListeners();
  }

  /// Fetches the [locality] reports from thew [ReportController.getAllReports], sorts and groups them by locality
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

  /// Sets the [_preferences.mobileData]
  void setMobileDataInfo(bool mobileData) {
    UserPreferencesController.setPrefsMobileData(mobileData);
    _preferences.mobileData = mobileData;
    notifyListeners();
  }

  /// Sets the [_preferences.gps]
  void setGpsInfo(bool gps) {
    UserPreferencesController.setPrefsGps(gps);
    _preferences.gps = gps;
    notifyListeners();
  }

  /// Sets the [_preferences.lang]
  void setLangInfo(Locale lang) {
    UserPreferencesController.setPrefsLang(lang);
    _preferences.lang = lang;
    notifyListeners();
  }

  /// Sets the [_position]
  void setPosition(LatLng position) {
    _position = position;
    notifyListeners();
  }
}
