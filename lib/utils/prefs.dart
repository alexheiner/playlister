
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';
import '../services/token.dart';

class Prefs {
  static late Token token;

  // call this method from iniState() function of mainApp().
  static init() async {
  }

  static void setToken(Token newToken) async =>
      token=newToken;

  static Token getToken() {
    return token;
  }
  // static Future<SharedPreferences> init() async {
  //   _prefs = await SharedPreferences.getInstance();
  //   return _prefs;
  // }

  // static Future<bool> setString(String key, String value) async =>
  //     await _prefs.setString(key, value);

  // static String getString(String key) {
  //   return _prefs.getString(key) ?? "";
  // }
}