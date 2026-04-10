import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setUserLoggedIn(bool value) async => await _prefs.setBool('isLoggedIn', value);
  static bool getUserLoggedIn() => _prefs.getBool('isLoggedIn') ?? false;

  static Future<void> saveUserName(String name) async => await _prefs.setString('userName', name);
  static String getUserName() => _prefs.getString('userName') ?? "";

  static Future<void> saveUserEmail(String email) async => await _prefs.setString('userEmail', email);
  static String getUserEmail() => _prefs.getString('userEmail') ?? "";

  static Future<void> logout() async => await _prefs.clear();
}