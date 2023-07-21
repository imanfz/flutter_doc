import 'package:flutter_doc/core/utilities/configs/app_config.dart';

import 'main.dart' as runner;

Future<void> main() async {
  AppConfig(
    flavor: FlavorType.prod,
  );
  await runner.main();
}
