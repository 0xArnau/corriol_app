import 'package:corriol_app/controllers/user_preferences_controller.dart';
import 'package:flutter/material.dart';

/// Class that represents the fields that a user preferences has
class UserPreferencesModel {
  /// Creates a [UserModel] instance.
  UserPreferencesModel({
    this.lang = const Locale("es"),
    this.mobileData = true,
    this.gps = true,
  });

  /// The preferred language for the user.
  ///
  /// The default value is 'es' (Spanish).
  Locale lang;

  /// Whether the user allows mobile data usage.
  ///
  /// The default value is `true`.
  bool mobileData;

  /// Whether the user allows GPS usage.
  ///
  /// The default value is `true`.
  bool gps;

  /// Converts the [UserPreferencesModel] instance to a JSON format.
  Map<String, dynamic> toJson() => {
        'lang': lang,
        'mobile_data': mobileData,
        'gps': gps,
      };

  /// Creates a new [UserPreferencesModel] instance from a JSON format.
  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) {
    return UserPreferencesModel(
      lang: Locale(json['lang']),
      mobileData: json['mobile_data'] == 'true',
      gps: json['gps'] == 'true',
    );
  }

  /// Retrieve the user preferences
  static Future<UserPreferencesModel> fromPreferences() async {
    final lang = await UserPreferencesController.getPrefsLang();
    final mobileData = await UserPreferencesController.getPrefsMobileData();
    final gps = await UserPreferencesController.getPrefsGps();

    return UserPreferencesModel(
        lang: Locale(lang), mobileData: mobileData, gps: gps);
  }
}
