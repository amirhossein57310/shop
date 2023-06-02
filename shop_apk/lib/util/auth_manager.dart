import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_apk/di/di.dart';

// class AuthManager {
//   static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
//   static final SharedPreferences sharedpref = locator.get();
//   static void saveToken(String token) {
//     sharedpref.setString('access_token', token);
//     authChangeNotifier.value = token;
//   }

//   static String readAuth() {
//     return sharedpref.getString('access_token') ?? 'null';
//   }

//   static void logOut() {
//     sharedpref.clear();
//     authChangeNotifier.value = null;
//   }

//   static bool isLogedin() {
//     String token = readAuth();
//     return token.isNotEmpty;
//   }
// }

class AuthManager {
  static final SharedPreferences _sharedpref = locator.get();
  static ValueNotifier valueNotifier = ValueNotifier(null);
  static void saveToken(String token) {
    _sharedpref.setString('access_token', token);
    valueNotifier.value = token;
  }

  static String readAuth() {
    return _sharedpref.getString('access_token') ?? 'null';
  }

  static void logout() {
    _sharedpref.clear();
    valueNotifier.value = null;
  }
}
