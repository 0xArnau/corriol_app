import 'package:corriol_app/controllers/auth_controller.dart';
import 'package:corriol_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late UserModel? _user;

  get data => _user;

  UserProvider() {
    _user = null;
  }

  Future<void> fetchUserInfo() async {
    _user = await AuthController().getUserInformation();
    notifyListeners();

    print("Update User info");
    print(_user!.toJson());
  }
}
