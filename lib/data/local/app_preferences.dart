import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  Future set<T>(String key, T content) async {
    final preferences = await SharedPreferences.getInstance();

    if (content is Map) {
      return preferences.setString(key, jsonEncode(content));
    }
    if (content is String) {
      return preferences.setString(key, content);
    }
    if (content is bool) {
      return preferences.setBool(key, content);
    }
    if (content is int) {
      return preferences.setInt(key, content);
    }
    if (content is double) {
      return preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      return preferences.setStringList(key, content);
    }
  }

  Future<dynamic> get(String key) async {
    final preferences = await SharedPreferences.getInstance();

    var content = preferences.get(key);
    if (content is String) {
      try {
        final map = json.decode(content.toString());
        return map;
      } catch (e, stacktrace) {
        debugPrintStack(stackTrace: stacktrace);
        return content;
      }
    }

    return content;
  }

  Future<bool> containtsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
