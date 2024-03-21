import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static const String fontSize = "font.size";
  static const String fontFamily = "font.family";
  static const String terminalTheme = "terminal.theme";
  static const String fontIsBold = "font.is.bold";

  static Future<SharedPreferences> get instance async {
    return await SharedPreferences.getInstance();
  }

  static Future<String> getString(String key,
      {String defaultValue = ''}) async {
    return (await instance).getString(key) ?? defaultValue;
  }

  static Future<void> setString(String key, String value) async {
    await (await instance).setString(key, value);
  }

  static Future<int> getInt(String key, {int defaultValue = 0}) async {
    return (await instance).getInt(key) ?? defaultValue;
  }

  static Future<void> setInt(String key, int value) async {
    await (await instance).setInt(key, value);
  }

  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    return (await instance).getBool(key) ?? defaultValue;
  }

  static Future<void> setBool(String key, bool value) async {
    await (await instance).setBool(key, value);
  }

  static Future<double> getDouble(String key, {double defaultValue = 0.0}) async {
    return (await instance).getDouble(key) ?? defaultValue;
  }

  static Future<void> setDouble(String key, double value) async {
    await (await instance).setDouble(key, value);
  }
}
