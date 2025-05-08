import 'package:firebase_cli/core/caches/prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setString(
      {required SharedPrefsKeys key, required String value}) async {
    await _preferences!.setString(key.name, value);
  }

  static String getString({required SharedPrefsKeys key,}){
    return _preferences?.getString(key.name) ?? "";
  }

  static Future<void> setInt({
    required SharedPrefsKeys key,
    required int value,
  }) async {
    await _preferences!.setInt(key.name, value);
  }

  static int getInt({
    required SharedPrefsKeys key,
  }) {
    return _preferences?.getInt(key.name) ?? 0;
  }

  static Future<void> setBool({
    required SharedPrefsKeys key,
    required bool value,
  }) async {
    await _preferences!.setBool(key.name, value);
  }

  static bool getBool({
    required SharedPrefsKeys key,
  }) {
    return _preferences?.getBool(key.name) ?? false;
  }

  static Future<void> remove({
    required SharedPrefsKeys key,
  }) async {
    await _preferences?.remove(key.name);
  }

  static Future<void> clear() async {
    await _preferences?.clear();
  }

}
