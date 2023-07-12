import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final TextEditingController _accountNameController =
      TextEditingController(text: 'flutter_secure_storage_service');

  IOSOptions _getIOSOptions() => IOSOptions(
        accountName: _getAccountName(),
      );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        sharedPreferencesName: 'app_secure_preferences',
        preferencesKeyPrefix: kDebugMode ? 'debug' : 'release',
      );

  String? _getAccountName() =>
      _accountNameController.text.isEmpty ? null : _accountNameController.text;

  Future<String> get(String key) async {
    return await _storage.read(
          key: key,
          iOptions: _getIOSOptions(),
          aOptions: _getAndroidOptions(),
        ) ??
        '';
  }

  Future<Map<String, String>> getAll(String key) async {
    return await _storage.readAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  Future put(String key, String? value) async {
    await _storage.write(
      key: key,
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  Future delete(String key) async {
    await _storage.read(
      key: key,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  Future deleteAll() async {
    await _storage.deleteAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(
      key: key,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }
}
