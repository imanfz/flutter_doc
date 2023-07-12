enum FlavorType { dev, prod }

class FlavorConfig {
  /// Flavor type
  final FlavorType flavor;

  /// Variables are dynamic
  final Map<String, dynamic> variables;

  /// Private constructor
  FlavorConfig._internal(this.flavor, this.variables);

  /// Internal instance of FlavorConfig
  static FlavorConfig? _instance;

  /// Factory constructor
  factory FlavorConfig({
    FlavorType flavor = FlavorType.dev,
    Map<String, dynamic> variables = const {},
  }) {
    return _instance = FlavorConfig._internal(flavor, variables);
  }

  /// Instance of FlavorConfig
  static FlavorConfig get instance => _instance ?? FlavorConfig();

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
}
