import 'package:flutter/material.dart';

class UserPreferencesModel {
  UserPreferencesModel({
    this.lang = const Locale("es"),
    this.mobileData = true,
    this.gps = true,
  });

  Locale lang;
  bool mobileData;
  bool gps;

  Map<String, dynamic> toJson() => {
        'lang': lang,
        'mobile_data': mobileData,
        'gps': gps,
      };

  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) {
    return UserPreferencesModel(
      lang: Locale(json['lang']),
      mobileData: json['mobile_data'] == 'true',
      gps: json['gps'] == 'true',
    );
  }
}
