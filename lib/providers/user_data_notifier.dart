import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:flutter/material.dart';

class UserDataNotifier with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUserData(UserModel? userModel) {
    _user = userModel;
    notifyListeners();
  }
}
