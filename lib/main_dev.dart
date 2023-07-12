import 'utilities/configs/flavor_config.dart';
import 'main.dart' as runner;

Future<void> main() async {
  FlavorConfig(
    flavor: FlavorType.dev,
  );

  await runner.main();
}