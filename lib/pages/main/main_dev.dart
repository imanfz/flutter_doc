import 'package:flutter_doc/core/configs/app_config.dart';

import 'main.dart' as runner;

Future<void> main() async {
  AppConfig(
    flavor: FlavorType.dev,
  );

  await runner.main();
}
