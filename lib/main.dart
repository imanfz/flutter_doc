import 'dart:async';
import 'package:flutter/material.dart';
import 'data/preferences/app_preferences.dart';
import '../presentation/pages/app.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences().set('key', 'adat');

  var a = await AppPreferences().get('key');
  runApp(const App());
}
