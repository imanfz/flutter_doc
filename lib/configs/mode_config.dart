import 'package:flutter/foundation.dart';

class ModeConfig {
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
