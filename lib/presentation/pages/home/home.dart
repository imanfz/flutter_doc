import 'package:flutter/material.dart';
import 'package:flutter_doc/utilities/extensions/context_ext.dart';
import 'package:flutter_doc/utilities/extensions/misc_ext.dart';
import 'package:flutter_doc/utilities/extensions/sizes_ext.dart';
import 'package:flutter_doc/utilities/extensions/text_styles_ext.dart';
import 'package:flutter_doc/presentation/widget/custom_button.dart';
import 'package:flutter_doc/presentation/widget/safe_on_tap.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../utilities/configs/flavor_config.dart';
import '../../../utilities/configs/mode_config.dart';
import '../app.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  const SizedBox(height: 16.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SafeOnTap(
                          child: SafeButton.primary(
                            onPressed: () {
                              context.showToast("Test");
                              print("toast ${DateTime.now()}");
                            },
                            label: 'Toast',
                          ),
                          onSafeTap: () => context.showToast('Toast')),
                      SafeButton.text(
                        onPressed: () =>
                            context.showSnackBar(message: 'SnackBar'),
                        label: 'Show snack bar',
                      ),
                      SafeButton.flatt(
                        onPressed: () => context.showBottomSheet(Padding(
                            padding: 16.paddingAll,
                            child: const Text('Bottom Sheet'))),
                        label: 'Bottom Sheet',
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.showLoading();
                          4.seconds.future(() {
                            context.hideLoading();
                          });
                        },
                        child: const Text('Show Loading'),
                      ),
                      SafeButton.outlined(
                        label: "Custom Button",
                        onPressed: () {
                          context.showAlertDialog("Test", "Custom");
                        },
                        backgroundColor: Colors.red,
                        borderRadius: 100,
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
