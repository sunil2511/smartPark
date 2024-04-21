import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreferences {
  static SharedPreferences? _prefs;

  // Create a constructor to initialize SharedPreferences.
  CustomSharedPreferences() {
    initPrefs();
  }

//Initalied SharedPreferences.
  static Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //Session Handle
  bool getStoreSession(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  Future<void> setStoreSession(String key, bool value) async {
    await _prefs?.setBool(
      key,
      value,
    );
  }

  //Splash Handle
  bool getSplashSession(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  Future<void> setSplashSession(String key, bool value) async {
    await _prefs?.setBool(
      key,
      value,
    );
  }

  //User Name Store
  String getStringValue(String key) {
    return _prefs?.getString(key) ?? "";
  }

  Future<void> setStringValue(String key, String value) async {
    await _prefs?.setString(
      key,
      value,
    );
  }

    //User Name Store
  double getDoubleValue(String key) {
    return _prefs?.getDouble(key) ?? 0.0;
  }

  Future<void> setDoubleValue(String key, double value) async {
    await _prefs?.setDouble(
      key,
      value,
    );
  }
}
