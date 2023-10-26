import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_apk/di/di.dart';

class AuthManager {
  static final SharedPreferences _sharedpref = locator.get();
  static ValueNotifier valueNotifier = ValueNotifier(null);
  static void saveToken(String token) {
    _sharedpref.setString('access_token', token);
    valueNotifier.value = token;
  }

  static String readAuth() {
    return _sharedpref.getString('access_token') ?? 'salam';
  }

  static void logout() {
    _sharedpref.clear();
    valueNotifier.value = null;
  }
}
