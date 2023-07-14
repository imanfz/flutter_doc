import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc/utilities/extensions/misc_ext.dart';
import 'package:flutter_doc/utilities/extensions/string_ext.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurePreferences extends _SecurePreferences {
  // Private Constructor
  SecurePreferences._() : super() {
    _init();
  }

  /// Method to get instance of class.
  static Future<SecurePreferences> getInstance() async {
    var object = SecurePreferences._();
    await object._init();
    return object;
  }

  Future<List<Map<String, List<int>>>> _getEncryptorKeys() async {
    List<Map<String, List<int>>> list = List.empty(growable: true);
    String keyEncryptorSubKey = await getString(
            _packageInfo.packageName + keyCode,
            isEncrypted: false) ??
        "";
    String valueEncryptorSubKey = await getString(
            _packageInfo.packageName + valueCode,
            isEncrypted: false) ??
        "";
    final intList = _getIntListFromString(keyEncryptorSubKey);
    Map<String, List<int>> keyEncryptorKeysList = {};
    keyEncryptorKeysList.putIfAbsent(
        _SecurePreferences.ivForKey, () => intList.getRange(0, 16).toList());
    keyEncryptorKeysList.putIfAbsent(
        _SecurePreferences.keyForKey, () => intList.getRange(16, 32).toList());
    list.add(keyEncryptorKeysList);

    final valueIntList = _getIntListFromString(valueEncryptorSubKey);
    Map<String, List<int>> valueEncryptorKeysList = {};
    valueEncryptorKeysList.putIfAbsent(_SecurePreferences.ivForKey,
        () => valueIntList.getRange(0, 16).toList());
    valueEncryptorKeysList.putIfAbsent(_SecurePreferences.keyForKey,
        () => valueIntList.getRange(16, 32).toList());
    list.add(valueEncryptorKeysList);
    return list;
  }

  /// Method to get String from local storage
  /// [key] -> Key which you have provided while setting
  /// [isEncrypted] -> Flag which you have provided while encrypting
  Future<String?> getString(String key, {bool isEncrypted = true}) async {
    if (isEncrypted && _platformEncryptionIsSupported) {
      if (Platform.isAndroid) {
        return await _secureStorage?.read(key: key);
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable()) {
          var keys = await _getEncryptorKeys();
          for (var value in _sharedPreferences.getKeys()) {
            if (_getIntListFromString(value).length == 16) {
              String decoded = await _decrypt(value, keys.first);
              if (decoded == key) {
                return await _decrypt(
                    _sharedPreferences.getString(value) ?? "", keys.last);
              }
            }
          }
        } else {
          throw Exception(
              "Failed to get data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(
            message: "Not Supported for ${Platform.operatingSystem} platform",
            code: "501");
      }
    } else {
      return _sharedPreferences.getString(key);
    }
    return null;
  }

  /// Method to get String from local storage
  /// [key] -> Key which you have provided while setting
  /// [isEncrypted] -> Flag which you have provided while encrypting
  Future<int?> getInt(String key, {bool isEncrypted = true}) async {
    if (isEncrypted && _platformEncryptionIsSupported) {
      if (Platform.isAndroid) {
        return int.tryParse(await _secureStorage?.read(key: key) ?? "0");
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable()) {
          print("_isMasterKeyAvailable true}");
          var keys = await _getEncryptorKeys();
          print("_getEncrypterKeys $keys}");
          for (var value in _sharedPreferences.getKeys()) {
            print("keys $value}");
            if (_getIntListFromString(value).length == 16) {
              String decoded = await _decrypt(value, keys.first);
              if (decoded == key) {
                print("decoded $decoded}");
                return int.tryParse(await _decrypt(
                    _sharedPreferences.getString(value) ?? "", keys.last));
              }
            }
          }
        } else {
          throw Exception(
              "Failed to get data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(
            message: "Not Supported for ${Platform.operatingSystem} platform",
            code: "501");
      }
    } else {
      return _sharedPreferences.getInt(key);
    }
    return 0;
  }

  /// Method to get boolean from local storage
  /// [key] -> Key which you have provided while setting
  /// [isEncrypted] -> Flag which you have provided while encrypting
  Future<bool?> getBool(String key, {bool isEncrypted = true}) async {
    if (isEncrypted && _platformEncryptionIsSupported) {
      if (Platform.isAndroid) {
        String? result = await _secureStorage?.read(key: key);
        return result?.toBool();
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable()) {
          var keys = await _getEncryptorKeys();
          for (var value in _sharedPreferences.getKeys()) {
            if (value.length >= 2 &&
                _getIntListFromString(value).length == 16) {
              String decoded = await _decrypt(value, keys.first);
              if (decoded == key) {
                String result = await _decrypt(
                    _sharedPreferences.getString(value) ?? "", keys.last);
                return result.toBool();
              }
            }
          }
        } else {
          throw Exception(
              "Failed to get data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(
            message: "Not Supported for ${Platform.operatingSystem} platform",
            code: "501");
      }
    } else {
      return _sharedPreferences.getBool(key);
    }
    return null;
  }

  /// Method to get double from local storage
  /// [key] -> Key which you have provided while setting
  /// [isEncrypted] -> Flag which you have provided while encrypting
  Future<double?> getDouble(String key, {bool isEncrypted = true}) async {
    if (isEncrypted && _platformEncryptionIsSupported) {
      if (Platform.isAndroid) {
        String? result = await _secureStorage?.read(key: key);
        return double.tryParse(result ?? "0.0");
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable()) {
          var keys = await _getEncryptorKeys();
          for (var value in _sharedPreferences.getKeys()) {
            if (_getIntListFromString(value).length == 16) {
              String decoded = await _decrypt(value, keys.first);
              if (decoded == key) {
                String result = await _decrypt(
                    _sharedPreferences.getString(value) ?? "", keys.last);
                return double.tryParse(result);
              }
            }
          }
        } else {
          throw Exception(
              "Failed to get data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(
            message: "Not Supported for ${Platform.operatingSystem} platform",
            code: "501");
      }
    } else {
      return _sharedPreferences.getDouble(key);
    }
    return null;
  }

  /// Method to get map from local storage
  /// [key] -> Key which you have provided while setting
  /// [isEncrypted] -> Flag which you have provided while encrypting
  Future<Map?> getMap(String key, {bool isEncrypted = true}) async {
    if (isEncrypted && _platformEncryptionIsSupported) {
      if (Platform.isAndroid) {
        String? result = await _secureStorage?.read(key: key);
        return jsonDecode(result ?? "{}");
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable()) {
          var keys = await _getEncryptorKeys();
          for (var value in _sharedPreferences.getKeys()) {
            if (_getIntListFromString(value).length == 16) {
              String decoded = await _decrypt(value, keys.first);
              if (decoded == key) {
                String result = await _decrypt(
                    _sharedPreferences.getString(value) ?? "", keys.last);
                return jsonDecode(result);
              }
            }
          }
        } else {
          throw Exception(
              "Failed to get data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(
            message: "Not Supported for ${Platform.operatingSystem} platform",
            code: "501");
      }
    } else {
      return jsonDecode(_sharedPreferences.getString(key) ?? "{}");
    }
    return null;
  }

  /// Method to get StringList from local storage
  /// [key] -> Key which you have provided while setting
  /// [isEncrypted] -> Flag which you have provided while encrypting
  Future<List<String>> getStringList(String key,
      {bool isEncrypted = true}) async {
    if (isEncrypted && _platformEncryptionIsSupported) {
      if (Platform.isAndroid) {
        String? result = await _secureStorage?.read(key: key);
        return _getStringListFromString(result!);
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable()) {
          var keys = await _getEncryptorKeys();
          for (var value in _sharedPreferences.getKeys()) {
            if (_getIntListFromString(value).length == 16) {
              String decoded = await _decrypt(value, keys.first);
              if (decoded == key) {
                String result = await _decrypt(
                    _sharedPreferences.getString(value) ?? "", keys.last);
                return _getStringListFromString(result);
              }
            }
          }
        } else {
          throw Exception(
              "Failed to get data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(
            message: "Not Supported for ${Platform.operatingSystem} platform",
            code: "501");
      }
    } else {
      return _sharedPreferences.getStringList(key) ?? [];
    }
    return [];
  }

  /// Method to set String in local storage
  /// [key] -> Key for key-value pair
  /// [isEncrypted] -> Flag whether to encrypt or not
  /// [val] -> Value for key-value pair
  Future<void> putString(String key, String val,
      {bool isEncrypted = true}) async {
    if (isEncrypted && _platformEncryptionIsSupported) {
      if (Platform.isAndroid) {
        _secureStorage?.write(key: key, value: val);
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable() && _areSubKeysAvailable()) {
          final keys = await _getEncryptorKeys();
          final algorithm = _cipher;

          final encryptedKey = await algorithm.encrypt(key.codeUnits,
              secretKey: SecretKey(keys.first[_SecurePreferences.keyForKey]!),
              nonce: keys.first[_SecurePreferences.ivForKey]);
          final encryptedValue = await algorithm.encrypt(val.codeUnits,
              secretKey: SecretKey(keys.last[_SecurePreferences.keyForKey]!),
              nonce: keys.last[_SecurePreferences.ivForKey]);
          _sharedPreferences.setString(encryptedKey.cipherText.toString(),
              encryptedValue.cipherText.toString());
        } else {
          if (await _isMasterKeyAvailable() &&
              _areSubKeysAvailable() == false) {
            await _deleteMasterKey();
          }
          var masterKey = await _createMasterKey();
          await _saveMasterKeyToKeychain(masterKey);
          await _generateAndSaveKeyAndValueSubKeys(
              await _getMasterKeyFromKeyChain());
          putString(key, val, isEncrypted: isEncrypted);
          //throw Exception("Failed to save data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(
            message: "Not Supported for ${Platform.operatingSystem} platform",
            code: "501");
      }
    } else {
      _sharedPreferences.setString(key, val);
    }
  }

  /// Method to set int in local storage
  /// [key] -> Key for key-value pair
  /// [isEncrypted] -> Flag whether to encrypt or not
  /// [val] -> Value for key-value pair
  Future<void> putInt(String key, int val, {bool isEncrypted = true}) async {
    if (isEncrypted && _platformEncryptionIsSupported) {
      if (Platform.isAndroid) {
        _secureStorage?.write(key: key, value: val.toString());
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable() && _areSubKeysAvailable()) {
          final keys = await _getEncryptorKeys();
          final algorithm = _cipher;

          final encryptedKey = await algorithm.encrypt(key.codeUnits,
              secretKey: SecretKey(keys.first[_SecurePreferences.keyForKey]!),
              nonce: keys.first[_SecurePreferences.ivForKey]);
          final encryptedValue = await algorithm.encrypt(
              val.toString().codeUnits,
              secretKey: SecretKey(keys.last[_SecurePreferences.keyForKey]!),
              nonce: keys.last[_SecurePreferences.ivForKey]);
          print("encryptedKey.cipherText ${encryptedKey.cipherText}");
          _sharedPreferences.setString(encryptedKey.cipherText.toString(),
              encryptedValue.cipherText.toString());
        } else {
          if (await _isMasterKeyAvailable() &&
              _areSubKeysAvailable() == false) {
            await _deleteMasterKey();
          }
          var masterKey = await _createMasterKey();
          await _saveMasterKeyToKeychain(masterKey);
          await _generateAndSaveKeyAndValueSubKeys(
              await _getMasterKeyFromKeyChain());
          putInt(key, val, isEncrypted: isEncrypted);
        }
      } else {
        throw PlatformException(
            message: "Not Supported for ${Platform.operatingSystem} platform",
            code: "501");
      }
    } else {
      _sharedPreferences.setInt(key, val);
    }
  }

  /// Method to set boolean in local storage
  /// [key] -> Key for key-value pair
  /// [isEncrypted] -> Flag whether to encrypt or not
  /// [val] -> Value for key-value pair
  Future<void> putBool(String key, bool val, {bool isEncrypted = true}) async {
    if (isEncrypted && _platformEncryptionIsSupported) {
      if (Platform.isAndroid) {
        _secureStorage?.write(key: key, value: val.toString());
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable() && _areSubKeysAvailable()) {
          final keys = await _getEncryptorKeys();
          final algorithm = _cipher;
          final encryptedKey = await algorithm.encrypt(key.codeUnits,
              secretKey: SecretKey(keys.first[_SecurePreferences.keyForKey]!),
              nonce: keys.first[_SecurePreferences.ivForKey]);
          final encryptedValue = await algorithm.encrypt(
              val.toString().codeUnits,
              secretKey: SecretKey(keys.last[_SecurePreferences.keyForKey]!),
              nonce: keys.last[_SecurePreferences.ivForKey]);
          _sharedPreferences.setString(encryptedKey.cipherText.toString(),
              encryptedValue.cipherText.toString());
        } else {
          if (await _isMasterKeyAvailable() &&
              _areSubKeysAvailable() == false) {
            await _deleteMasterKey();
          }
          var masterKey = await _createMasterKey();
          await _saveMasterKeyToKeychain(masterKey);
          await _generateAndSaveKeyAndValueSubKeys(
              await _getMasterKeyFromKeyChain());
          putBool(key, val, isEncrypted: isEncrypted);
        }
      } else {
        throw PlatformException(
            message: "Not Supported for ${Platform.operatingSystem} platform",
            code: "501");
      }
    } else {
      _sharedPreferences.setBool(key, val);
    }
  }

  /// Method to set map in local storage
  /// [key] -> Key for key-value pair
  /// [isEncrypted] -> Flag whether to encrypt or not
  /// [val] -> Value for key-value pair
  Future<void> putMap(String key, Map val, {bool isEncrypted = true}) async {
    await putString(key, jsonEncode(val), isEncrypted: isEncrypted);
  }

  /// Method to set double in local storage
  /// [key] -> Key for key-value pair
  /// [isEncrypted] -> Flag whether to encrypt or not
  /// [val] -> Value for key-value pair
  Future<void> putDouble(String key, double val,
      {bool isEncrypted = true}) async {
    if (isEncrypted && _platformEncryptionIsSupported) {
      if (Platform.isAndroid) {
        _secureStorage?.write(key: key, value: val.toString());
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable() && _areSubKeysAvailable()) {
          final keys = await _getEncryptorKeys();
          final algorithm = _cipher;

          final encryptedKey = await algorithm.encrypt(key.codeUnits,
              secretKey: SecretKey(keys.first[_SecurePreferences.keyForKey]!),
              nonce: keys.first[_SecurePreferences.ivForKey]);
          final encryptedValue = await algorithm.encrypt(
              val.toString().codeUnits,
              secretKey: SecretKey(keys.last[_SecurePreferences.keyForKey]!),
              nonce: keys.last[_SecurePreferences.ivForKey]);
          _sharedPreferences.setString(encryptedKey.cipherText.toString(),
              encryptedValue.cipherText.toString());
        } else {
          if (await _isMasterKeyAvailable() &&
              _areSubKeysAvailable() == false) {
            await _deleteMasterKey();
          }
          var masterKey = await _createMasterKey();
          await _saveMasterKeyToKeychain(masterKey);
          await _generateAndSaveKeyAndValueSubKeys(
              await _getMasterKeyFromKeyChain());
          putDouble(key, val, isEncrypted: isEncrypted);
        }
      } else {
        throw PlatformException(
            message: "Not Supported for ${Platform.operatingSystem} platform",
            code: "501");
      }
    } else {
      _sharedPreferences.setDouble(key, val);
    }
  }

  /// Method to set StringList in local storage
  /// [key] -> Key for key-value pair
  /// [isEncrypted] -> Flag whether to encrypt or not
  /// [val] -> Value for key-value pair
  Future<void> putStringList(String key, List<String> val,
      {bool isEncrypted = true}) async {
    if (isEncrypted && _platformEncryptionIsSupported) {
      if (Platform.isAndroid) {
        _secureStorage?.write(key: key, value: val.toString());
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable() && _areSubKeysAvailable()) {
          final keys = await _getEncryptorKeys();
          final algorithm = _cipher;

          final encryptedKey = await algorithm.encrypt(key.codeUnits,
              secretKey: SecretKey(keys.first[_SecurePreferences.keyForKey]!),
              nonce: keys.first[_SecurePreferences.ivForKey]);
          final encryptedValue = await algorithm.encrypt(
              val.toString().codeUnits,
              secretKey: SecretKey(keys.last[_SecurePreferences.keyForKey]!),
              nonce: keys.last[_SecurePreferences.ivForKey]);
          _sharedPreferences.setString(encryptedKey.cipherText.toString(),
              encryptedValue.cipherText.toString());
        } else {
          if (await _isMasterKeyAvailable() &&
              _areSubKeysAvailable() == false) {
            await _deleteMasterKey();
          }
          var masterKey = await _createMasterKey();
          await _saveMasterKeyToKeychain(masterKey);
          await _generateAndSaveKeyAndValueSubKeys(
              await _getMasterKeyFromKeyChain());
          putStringList(key, val, isEncrypted: isEncrypted);
        }
      } else {
        throw PlatformException(
            message: "Not Supported for ${Platform.operatingSystem} platform",
            code: "501");
      }
    } else {
      _sharedPreferences.setStringList(key, val);
    }
  }

  Future<void> remove(String key) async {}

  /// Method for deleting all data.
  Future<void> clearAll() async {
    await _sharedPreferences.clear();
    await _secureStorage?.deleteAll();
  }
}

class _SecurePreferences {
  FlutterSecureStorage? _secureStorage;
  late PackageInfo _packageInfo;
  late SharedPreferences _sharedPreferences;

  final String keyCode = "secure_preferences_key";
  final String valueCode = "secure_preferences_value";
  static const String keyForKey = "keyForKey";
  static const String ivForKey = "ivForKey";

  _SecurePreferences() {
    PackageInfo.fromPlatform().then((value) async {
      _packageInfo = value;
      final AndroidOptions _androidOptions = AndroidOptions(
        encryptedSharedPreferences: true,
        sharedPreferencesName: '${value.appName}_prefs',
        preferencesKeyPrefix: kDebugMode ? 'debug' : 'release',
      );
      final IOSOptions _iosOptions = IOSOptions(
          accountName: '${value.packageName}_prefs', synchronizable: false);
      _secureStorage ??= FlutterSecureStorage(
          aOptions: _androidOptions, iOptions: _iosOptions);
      _init();
    });
  }

  _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  List<String> _getStringListFromString(String result) =>
      result.substring(1, result.length - 1).split(',').toList();

  bool get _platformEncryptionIsSupported =>
      !kIsWeb && Platform.isAndroid || Platform.isIOS;

  // AES-CBC with 128 bit keys and HMAC-SHA256 authentication.
  Cipher _cipher = AesCbc.with128bits(macAlgorithm: MacAlgorithm.empty);

  List<int> _getIntListFromString(String keyEncryptorSubKey) =>
      keyEncryptorSubKey
          .substring(1, keyEncryptorSubKey.length - 1)
          .split(',')
          .map((e) => int.tryParse(e) ?? 0)
          .toList();

  Future<String> _decrypt(String string, Map<String, List<int>> keys) async {
    final box = SecretBox(_getIntListFromString(string),
        nonce: keys[ivForKey]!, mac: Mac.empty);
    final secretKey = SecretKey(keys[keyForKey]!);
    final decrypted = await _cipher.decrypt(box, secretKey: secretKey);
    this.log("decrypted $decrypted");
    return const Utf8Decoder().convert(decrypted);
  }

  Future<bool> _isMasterKeyAvailable() async {
    return _secureStorage?.read(key: '${_packageInfo.packageName}_prefs') !=
        null;
  }

  Future<String> _createMasterKey() async {
    final generator = Random.secure();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final masterKey = String.fromCharCodes(Iterable.generate(
        32, (_) => _chars.codeUnitAt(generator.nextInt(_chars.length))));
    return masterKey;
  }

  _deleteMasterKey() async {
    await _secureStorage?.delete(key: _packageInfo.packageName);
  }

  _saveMasterKeyToKeychain(String masterKey) async {
    await _secureStorage?.write(
        key: _packageInfo.packageName, value: masterKey);
  }

  Future<String> _getMasterKeyFromKeyChain() async {
    return await _secureStorage?.read(key: _packageInfo.packageName) ?? "";
  }

  bool _areSubKeysAvailable() {
    var keyKey =
        _sharedPreferences.getString(_packageInfo.packageName + keyCode);
    var valueKey =
        _sharedPreferences.getString(_packageInfo.packageName + valueCode);
    return keyKey != null && valueKey != null;
  }

  Future<void> _generateAndSaveKeyAndValueSubKeys(String masterKey) async {
    // AES-CBC with 128 bit keys and HMAC-SHA256 authentication.
    final secretKey = await _cipher.newSecretKey();
    final nonce = _cipher.newNonce();
    final keyBytes = await secretKey.extractBytes();

    final List<int> subKeyKey = List.empty(growable: true);
    subKeyKey.addAll(nonce);
    subKeyKey.addAll(keyBytes);
    await _sharedPreferences.setString(
        _packageInfo.packageName + keyCode, subKeyKey.toString());

    final List<int> subKeyValue = List.empty(growable: true);
    subKeyValue.addAll(nonce);
    subKeyValue.addAll(keyBytes);
    await _sharedPreferences.setString(
        _packageInfo.packageName + valueCode, subKeyValue.toString());
  }
}
