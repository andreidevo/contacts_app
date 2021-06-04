import 'package:shared_preferences/shared_preferences.dart';


class Const {

  static const String PATH = 'PATH';

}

class Prefs {

  static Future<String> get path => PreferencesHelper.getString(Const.PATH);
  static Future setPath(String value) => PreferencesHelper.setString(Const.PATH, value);

}

class PreferencesHelper {

  static Future<String> getString(String key) async {
    final p = await prefs;
    return p.getString(key) ?? '';
  }


  static Future setString(String key, String value) async {
    final p = await prefs;
    return p.setString(key, value);
  }

  static Future<bool> getBool(String key) async {
    final p = await prefs;
    return p.getBool(key) ?? false;
  }

  static Future setBool(String key, bool value) async {
    final p = await prefs;
    return p.setBool(key, value);
  }

  static Future<int> getInt(String key) async {
    final p = await prefs;
    return p.getInt(key) ?? 0;
  }

  static Future setInt(String key, int value) async {
    final p = await prefs;
    return p.setInt(key, value);
  }



  static Future<double> getDouble(String key) async {
    final p = await prefs;
    return p.getDouble(key) ?? 0.0;
  }

  static Future setDouble(String key, double value) async {
    final p = await prefs;
    return p.setDouble(key, value);
  }

  // helper
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}