import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doc/core/utilities/common/device_info.dart';
import 'package:flutter_doc/core/utilities/configs/flavor_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../core/utilities/common/custom_color_scheme.dart';
import '../home/home_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();

  /// InheritedWidget style accessor to our State object.
  static _AppState of(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>()!;
}

class _AppState extends State<App> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
  }

  void setTheme(ThemeMode t) async {
    setState(() {
      themeMode = t;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      title: FlavorConfig.instance.title,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        extensions: <ThemeExtension<dynamic>>[
          CustomColors.light,
        ],
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        extensions: <ThemeExtension<dynamic>>[
          CustomColors.dark,
        ],
      ),
      themeMode: themeMode,
      navigatorObservers:
          FlavorConfig.instance.flavor == FlavorType.dev && kDebugMode
              ? [ChuckerFlutter.navigatorObserver]
              : [],
      home: _flavorBanner(
        child: const Scaffold(
          body: SafeArea(
            bottom: false,
            child: HomePage(),
          ),
        ),
        show: kDebugMode,
      ),
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: FlavorConfig.instance.name,
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  letterSpacing: 1.0),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : Container(
              child: child,
            );
}
