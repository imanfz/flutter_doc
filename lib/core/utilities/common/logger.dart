import 'dart:developer' as devtools show log;

import 'package:flutter/foundation.dart';
import 'package:flutter_doc/core/utilities/extensions/misc_ext.dart';

/// Logs an Object
///
/// Instead of doing
/// `log(object.toString())`
/// you can do
/// `object.logDebug()`
/// only on debug mode, otherwise it doesn't show up
void printDebug(String message, {String? tag}) {
  if (kDebugMode) {
    devtools.log(message, name: tag ?? '');
  }
}

/// Logs an Object
///
/// Instead of doing
/// `log(object.toString())`
/// you can do
/// `object.logInfo()`
/// Log info
void printInfo(String message, {String? tag}) {
  devtools.log(message, name: tag ?? '');
}

/// Logs an Object
///
/// Instead of doing
/// `log(object.toString())`
/// you can do
/// `object.logError()`
/// Log error
void printError(String message, {String? tag, StackTrace? stackTrace}) {
  devtools.log('', error: message, name: tag ?? '', stackTrace: stackTrace);
}

/// Logs an Object
///
/// Instead of doing
/// `print(jsonString)`
/// you can do
/// `object.printPrettyJson(jsonString)`
/// example [json]: {"code":"0","text":"hello world"}
void printPrettyJson(String json, {String? tag}) {
  try {
      var object = decoder.convert(json);
      var prettyString = encoder.convert(object);
      printInfo(prettyString, tag: tag ?? '');
    } catch (e) {
      printInfo(json);
    }
}

/// Logger extensions
extension Logger on Object {
  // creating TAG from classname
  String get TAG => runtimeType.toString();

  /// Logs an Object
  ///
  /// Instead of doing
  /// `log(object.toString())`
  /// you can do
  /// `object.logDebug()`
  /// only on debug mode, otherwise it doesn't show up
  void logDebug(String message, {String? tag}) {
    if (kDebugMode) {
      devtools.log(message, name: tag ?? TAG);
    }
  }

  /// Logs an Object
  ///
  /// Instead of doing
  /// `log(object.toString())`
  /// you can do
  /// `object.logInfo()`
  /// Log info
  void logInfo(String message, {String? tag}) {
    devtools.log(message, name: tag ?? TAG);
  }

  /// Logs an Object
  ///
  /// Instead of doing
  /// `log(object.toString())`
  /// you can do
  /// `object.logError()`
  /// Log error
  void logError(String message, {String? tag, StackTrace? stackTrace}) {
    devtools.log('', error: message, name: tag ?? TAG, stackTrace: stackTrace);
  }

  /// Logs an Object
  ///
  /// Instead of doing
  /// `print(jsonString)`
  /// you can do
  /// `object.printPrettyJson(jsonString)`
  /// example [json]: {"code":"0","text":"hello world"}
  void printPrettyJson(String json, {String? tag}) {
    try {
      var object = decoder.convert(json);
      var prettyString = encoder.convert(object);
      logInfo(prettyString, tag: tag ?? TAG);
    } catch (e) {
      logInfo(json);
    }
  }
}
