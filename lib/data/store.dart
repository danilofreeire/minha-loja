import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static Future<bool> saveString(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value.toString());
  }

  static Future<bool> saveMap(String key, Map<String, dynamic> value) async {
    return saveString(key, json.encode(value));
  }

  static Future<String?> getString(
    String key, [
    String defaultValue = '',
  ]) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<Map<String, dynamic>> getMap(
    String key, [
    Map<String, dynamic> defaultValue = const {},
  ]) async {
    try {
      return jsonDecode(await getString(key) ?? json.encode(defaultValue));
    } catch (e) {
      return defaultValue;
    }
  }

  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
