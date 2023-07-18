import 'package:flutter/material.dart';
import 'package:flutter_doc/presentation/pages/login/login_page.dart';
import 'package:flutter_doc/presentation/widget/safe_button.dart';
import 'package:flutter_doc/utilities/extensions/context_ext.dart';
import 'package:flutter_doc/utilities/extensions/misc_ext.dart';
import 'package:flutter_doc/utilities/extensions/navigator_ext.dart';
import 'package:flutter_doc/utilities/extensions/string_ext.dart';
import 'package:flutter_doc/utilities/extensions/text_styles_ext.dart';
import 'package:flutter_doc/utilities/extensions/widget_ext.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../data/datasources/preferences/secure_preferences.dart';
import '../../../utilities/configs/flavor_config.dart';
import '../../../utilities/configs/mode_config.dart';
import '../app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      switch (themeMode) {
        case ThemeMode.system:
        case ThemeMode.light:
          themeMode = ThemeMode.dark;
          break;
        case ThemeMode.dark:
          themeMode = ThemeMode.light;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlavorConfig.instance.title),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text('Iman Faizal'.getInitialName()),
          ).paddingRight(16).onSafeTap(() {
            log('Icon avatar tapped');
          }),
        ],
      ),
      body: FutureBuilder(
        future: PackageInfo.fromPlatform(),
        builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
          if (!snapshot.hasData) return Container();
          PackageInfo? packageInfo = snapshot.data;
          return SingleChildScrollView(
            child: SizedBox(
              width: context.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Divider(),
                  Text(
                    "Belajar Flutter Flavor dan Flutter Mode",
                    textAlign: TextAlign.center,
                    style: context.bodyLarge,
                  ),
                  const Divider(height: 32, thickness: 2),
                  Text(
                    "Flavor: ${FlavorConfig.instance.name}",
                    textAlign: TextAlign.center,
                    style: context.bodyMedium,
                  ),
                  Text(
                    "Mode: ${ModeConfig.mode}",
                    textAlign: TextAlign.center,
                    style: context.bodyMedium,
                  ),
                  const Divider(height: 32, thickness: 2),
                  Text(
                    "App Name : ${packageInfo?.appName}",
                    textAlign: TextAlign.center,
                    style: context.bodyMedium,
                  ),
                  Text(
                    "Package Name : ${packageInfo?.packageName}",
                    textAlign: TextAlign.center,
                    style: context.bodyMedium,
                  ),
                  Text(
                    "Version Name : ${packageInfo?.version}",
                    textAlign: TextAlign.center,
                    style: context.bodyMedium,
                  ),
                  Text(
                    "Currency IDR sample : ${'20500'.toCurrency(decimalDigits: 0)}",
                    textAlign: TextAlign.center,
                    style: context.bodyMedium,
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SafeButton.primary(
                        label: 'Show Toast',
                        onPressed: () {
                          log('test toast');
                          context.showToast("Sample Toast");
                        },
                        icon: Icons.add,
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                      SafeButton.text(
                        label: 'Show SnackBar',
                        onPressed: () =>
                            context.showSnackBar('Sample SnackBar'),
                      ),
                      SafeButton.flatt(
                        label: 'Bottom Sheet',
                        onPressed: () => context.showBottomSheet(
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Sample Bottom Sheet'),
                              Text('Lorem Ipsum Lo')
                            ],
                          ),
                        ),
                      ),
                      SafeButton.primary(
                        label: 'Show Loading',
                        onPressed: () {
                          context.showLoading();
                          4.seconds.future(() {
                            context.hideLoading();
                          });
                        },
                        backgroundColor: Colors.yellow,
                      ),
                      SafeButton.outlined(
                        label: "Show Alert Dialog",
                        onPressed: () {
                          context.showAlertDialog(
                              "Test", "Sample Alert Dialog");
                        },
                        borderRadius: 100,
                      ),
                      SafeButton.flatt(
                        label: "Show Action Dialog",
                        onPressed: () {
                          context.showActionDialog(
                            "Test",
                            "Sample Action Dialog",
                            onPressed: () async {
                              final prefs =
                                  await SecurePreferences.getInstance();
                              prefs.putString('test', 'hello world');

                              var a = await prefs.getString('test');
                              debugPrint(a);
                            },
                          );
                        },
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                      ),
                      SafeButton.primary(
                        label: "Go to LoginPage",
                        onPressed: () {
                          context.navigator.pushMaterial(LoginPage());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: SafeButton.floating(
        onPressed: () {
          toggleTheme();
          App.of(context).setTheme(themeMode);
        },
        tooltip: 'Change theme setting',
        icon: themeMode == ThemeMode.light
            ? Icons.dark_mode_outlined
            : Icons.light_mode_outlined,
      ),
    );
  }
}
