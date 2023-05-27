import 'dart:convert';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

class SecureStorageApi {
  static final encryptedSharedPreferences = EncryptedSharedPreferences();

  static Future<String> read({required String key}) async {
    return await encryptedSharedPreferences.getString(key);
  }

  static Future write({required String key, required String value}) async {
    return await encryptedSharedPreferences.setString(key, value);
  }

  static Future readObject(String key) async {
    try {
      String value = await encryptedSharedPreferences.getString(key);
      if (value == "") {
        return null;
      }
      return json.decode(value);
    } catch (e) {
      return null;
    }
  }

  static Future saveObject(String key, value) async {
    await encryptedSharedPreferences.setString(key, json.encode(value));
  }

  static Future delete({required String key}) async {
    return await encryptedSharedPreferences.remove(key);
  }

  static Future deleteAll() async {
    return await encryptedSharedPreferences.clear();
  }
}
