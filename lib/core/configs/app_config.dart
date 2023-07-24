import 'package:flutter/foundation.dart';

enum FlavorType { dev, prod }

class AppConfig {
  /// Flavor type
  final FlavorType flavor;

  /// Variables are dynamic
  final Map<String, dynamic> variables;

  /// Private constructor
  AppConfig._internal(this.flavor, this.variables);

  /// Internal instance of FlavorConfig
  static AppConfig? _instance;

  /// Factory constructor
  factory AppConfig({
    FlavorType flavor = FlavorType.dev,
    Map<String, dynamic> variables = const {},
  }) {
    return _instance = AppConfig._internal(flavor, variables);
  }

  /// Instance of FlavorConfig
  static AppConfig get instance => _instance ?? AppConfig();

  String get name => flavor.name;

  String get title {
    switch (flavor) {
      case FlavorType.dev:
        return 'Dev Flutter Doc';
      case FlavorType.prod:
        return 'Flutter Doc';
      default:
        return 'title';
    }
  }

  String get baseUrl {
    switch (flavor) {
      case FlavorType.dev:
        return 'https://dev.com';
      case FlavorType.prod:
        return 'https://prod.com';
      default:
        return 'https://google.com';
    }
  }

  static bool get isDebug => kDebugMode;

  static bool get isRelease => kReleaseMode;

  static bool get isProfile => kProfileMode;

  static String get mode => isDebug
      ? "debug"
      : isRelease
          ? "release"
          : isProfile
              ? "profile"
              : "unknown";
}
