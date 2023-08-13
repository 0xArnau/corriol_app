import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/controllers/geolocation_controller.dart';
import 'package:corriol_app/controllers/user_preferences_controller.dart';
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

  /// Return the [UserModel] instance of the current user.
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

  /// Initialize the [UserPreferencesModel].
  Future<void> init() async {
    _preferences = await UserPreferencesModel.fromPreferences();
    notifyListeners();
    // fetchPosition();
  }

  /// Fetches the [UserModel] info from the [AuthController.getUserInformation].
  Future<void> fetchUserInfo() async {
    _user = await AuthController().getUserInformation();
    notifyListeners();
  }

  /// Fetches the [UserPreferencesModel.mobileData] info from the [UserPreferencesController.getPrefsMobileData].
  void fetchMobileDataInfo() async {
    bool? mobileData = await UserPreferencesController.getPrefsMobileData();
    _preferences.mobileData = mobileData;
    notifyListeners();
  }

  /// Fetches the [UserPreferencesModel.gps] info from the [UserPreferencesController.getPrefsGps].
  void fetchGpsInfo() async {
    bool? gpsValue = await UserPreferencesController.getPrefsGps();
    _preferences.gps = gpsValue;
    notifyListeners();
  }

  /// Fetches the [UserPreferencesModel.lang] info from the [UserPreferencesController.getPrefsLang].
  void fetchLangInfo() async {
    String? lang = await UserPreferencesController.getPrefsLang();
    _preferences.lang = Locale(lang);
    notifyListeners();
  }

  /// Fetches the [_position] info from the [GeolocationController.getCurrentLocation].
  void fetchPosition(BuildContext context) async {
    final position =
        await GeolocationController().getCurrentLocation(context, this);

    if (position == null) return;

    _position = LatLng(position.latitude, position.longitude);
    notifyListeners();
  }

  /// Sets the [UserPreferencesModel.mobileData]
  void setMobileDataInfo(bool mobileData) {
    UserPreferencesController.setPrefsMobileData(mobileData);
    _preferences.mobileData = mobileData;
    notifyListeners();
  }

  /// Sets the [UserPreferencesModel.gps]
  void setGpsInfo(bool gps) {
    UserPreferencesController.setPrefsGps(gps);
    _preferences.gps = gps;
    notifyListeners();
  }

  /// Sets the [UserPreferencesModel.lang]
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
