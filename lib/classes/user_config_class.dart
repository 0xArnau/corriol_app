import 'dart:convert';
import 'package:corriol_app/classes/file_io_class.dart';
import 'package:flutter/material.dart';

class UserConfigClass extends ChangeNotifier {
  UserConfigClass({required this.locale, required this.mobileData});

  late Locale locale;
  late bool mobileData;

  final FileIoClass file = FileIoClass(fileName: 'user_config.cfg');

  factory UserConfigClass.fromJson(Map<String, dynamic> json) {
    return UserConfigClass(
      locale: Locale(json['locale']),
      mobileData: json['mobile_data'],
    );
  }

  Map<String, dynamic> toJson() => {
        'locale': locale,
        'mobile_data': mobileData,
      };

  Future<void> loadConfig() async {
    try {
      if (await file.fileExists()) {
        final jsonStr = await file.readContent();
        final jsonMap = jsonDecode(jsonStr);
        final userConfig = UserConfigClass.fromJson(jsonMap);
        locale = userConfig.locale;
        mobileData = userConfig.mobileData;
        notifyListeners();
        print("loaded");
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  void saveConfig() async {
    try {
      // file.reWriteContent(
      //   jsonEncode(
      //     toJson(),
      //   ),
      // );
      // notifyListeners();
      print("saved");
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}
