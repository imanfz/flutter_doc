import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/local/app_preferences.dart';
import '../app.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences().set('key', 'adat');

  var a = await AppPreferences().get('key');
  runApp(const App());
}
