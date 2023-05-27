import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static var prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  readObject(String key) async {
    return json.decode(prefs.getString(key));
  }

  saveObject(String key, value) async {
    prefs.setString(key, json.encode(value));
  }

  save(String key, value) async {
    prefs.setString(key, value);
  }

  remove(String key) async {
    prefs.remove(key);
  }

  clear() async {
    prefs.clear();
  }
}