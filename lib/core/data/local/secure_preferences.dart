import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_doc/core/utils/extensions/string_ext.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurePreferences {
  late FlutterSecureStorage _secureStorage;
  late SharedPreferences _sharedPreferences;

  static SecurePreferences? _instance;

  SecurePreferences._(this._secureStorage, this._sharedPreferences);

  /// Method to get instance of class.
  static Future<SecurePreferences> geInstance() async {
    if (_instance == null) {
      final packageInfo = await PackageInfo.fromPlatform();
      String prefix = kDebugMode ? 'debug' : 'release';
      AndroidOptions _androidOptions = AndroidOptions(
        encryptedSharedPreferences: true,
        sharedPreferencesName: packageInfo.appName,
        preferencesKeyPrefix: prefix,
      );
      IOSOptions _iosOptions = IOSOptions(
        accountName: '${packageInfo.packageName}.$prefix',
        accessibility: KeychainAccessibility.first_unlock,
      );
      final secureStorage = FlutterSecureStorage(
          aOptions: _androidOptions, iOptions: _iosOptions);
      final sharedPreferences = await SharedPreferences.getInstance();
      _instance = SecurePreferences._(secureStorage, sharedPreferences);
    }

    return _instance!;
  }

  /// Method to get instance of class.
  List<String> _getStringListFromString(String result) =>
      result.substring(1, result.length - 1).split(',').toList();

  /// Method to get String from local storage
  /// [key] -> Key which you have provided while setting
  /// [isEncrypted] -> Flag which you have provided while encrypting
  Future<String?> getString(String key, {bool isEncrypted = false}) async {
    if (isEncrypted) {
      return await _secureStorage.read(key: key);
    } else {
      return _sharedPreferences.getString(key);
    }
  }

  /// Method to get String from local storage
  /// [key] -> Key which you have provided while setting
  /// [isEncrypted] -> Flag which you have provided while encrypting
  Future<int?> getInt(String key, {bool isEncrypted = false}) async {
    if (isEncrypted) {
      return int.tryParse(await _secureStorage.read(key: key) ?? "0");
    } else {
      return _sharedPreferences.getInt(key);
    }
  }

  /// Method to get boolean from local storage
  /// [key] -> Key which you have provided while setting
  /// [isEncrypted] -> Flag which you have provided while encrypting
  Future<bool?> getBool(String key, {bool isEncrypted = false}) async {
    if (isEncrypted) {
      String? result = await _secureStorage.read(key: key);
      return result?.toBool();
    } else {
      return _sharedPreferences.getBool(key);
    }
  }

  /// Method to get double from local storage
  /// [key] -> Key which you have provided while setting
  /// [isEncrypted] -> Flag which you have provided while encrypting
  Future<double?> getDouble(String key, {bool isEncrypted = false}) async {
    if (isEncrypted) {
      String? result = await _secureStorage.read(key: key);
      return double.tryParse(result ?? "0.0");
    } else {
      return _sharedPreferences.getDouble(key);
    }
  }

  /// Method to get map from local storage
  /// [key] -> Key which you have provided while setting
  /// [isEncrypted] -> Flag which you have provided while encrypting
  Future<Map?> getMap(String key, {bool isEncrypted = false}) async {
    if (isEncrypted) {
      String? result = await _secureStorage.read(key: key);
      return jsonDecode(result ?? "{}");
    } else {
      return jsonDecode(_sharedPreferences.getString(key) ?? "{}");
    }
  }

  /// Method to get StringList from local storage
  /// [key] -> Key which you have provided while setting
  /// [isEncrypted] -> Flag which you have provided while encrypting
  Future<List<String>> getStringList(String key,
      {bool isEncrypted = false}) async {
    if (isEncrypted) {
      String? result = await _secureStorage.read(key: key);
      return _getStringListFromString(result!);
    } else {
      return _sharedPreferences.getStringList(key) ?? [];
    }
  }

  /// Method to set String in local storage
  /// [key] -> Key for key-value pair
  /// [isEncrypted] -> Flag whether to encrypt or not
  /// [val] -> Value for key-value pair
  Future<void> putString(String key, String val,
      {bool isEncrypted = false}) async {
    if (isEncrypted) {
      await _secureStorage.write(key: key, value: val);
    } else {
      _sharedPreferences.setString(key, val);
    }
  }

  /// Method to set int in local storage
  /// [key] -> Key for key-value pair
  /// [isEncrypted] -> Flag whether to encrypt or not
  /// [val] -> Value for key-value pair
  Future<void> putInt(String key, int val, {bool isEncrypted = false}) async {
    if (isEncrypted) {
      await _secureStorage.write(key: key, value: val.toString());
    } else {
      _sharedPreferences.setInt(key, val);
    }
  }

  /// Method to set boolean in local storage
  /// [key] -> Key for key-value pair
  /// [isEncrypted] -> Flag whether to encrypt or not
  /// [val] -> Value for key-value pair
  Future<void> putBool(String key, bool val, {bool isEncrypted = false}) async {
    if (isEncrypted) {
      await _secureStorage.write(key: key, value: val.toString());
    } else {
      _sharedPreferences.setBool(key, val);
    }
  }

  /// Method to set map in local storage
  /// [key] -> Key for key-value pair
  /// [isEncrypted] -> Flag whether to encrypt or not
  /// [val] -> Value for key-value pair
  Future<void> putMap(String key, Map val, {bool isEncrypted = false}) async {
    await putString(key, jsonEncode(val), isEncrypted: isEncrypted);
  }

  /// Method to set double in local storage
  /// [key] -> Key for key-value pair
  /// [isEncrypted] -> Flag whether to encrypt or not
  /// [val] -> Value for key-value pair
  Future<void> putDouble(String key, double val,
      {bool isEncrypted = false}) async {
    if (isEncrypted) {
      _secureStorage.write(key: key, value: val.toString());
    } else {
      _sharedPreferences.setDouble(key, val);
    }
  }

  /// Method to set StringList in local storage
  /// [key] -> Key for key-value pair
  /// [isEncrypted] -> Flag whether to encrypt or not
  /// [val] -> Value for key-value pair
  Future<void> putStringList(String key, List<String> val,
      {bool isEncrypted = false}) async {
    if (isEncrypted) {
      _secureStorage.write(key: key, value: val.toString());
    } else {
      _sharedPreferences.setStringList(key, val);
    }
  }

  /// Method for deleting data by key.
  Future<void> remove(String key) async {
    await _sharedPreferences.remove(key);
    await _secureStorage.delete(key: key);
  }

  /// Method for deleting all data.
  Future<void> clearAll() async {
    await _sharedPreferences.clear();
    await _secureStorage.deleteAll();
  }
}
