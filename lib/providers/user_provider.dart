import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late UserModel? _user;
  late bool _mobileData;
  late bool _gps;
  late Locale _lang;

  get user => _user;
  get mobileData => _mobileData;
  get gps => _gps;
  get lang => _lang;

  UserProvider() {
    _user = null;
    _mobileData = false;
    _gps = false;
  }

  Future<void> fetchUserInfo() async {
    _user = await AuthController().getUserInformation();
    notifyListeners();
  }

  Future<void> fetchMobileDataInfo() async {
    notifyListeners();
  }

  Future<void> fetchGpsInfo() async {
    notifyListeners();
  }

  Future<void> fetchLangInfo() async {
    notifyListeners();
  }
}
