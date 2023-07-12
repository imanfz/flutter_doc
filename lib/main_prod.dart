import 'utilities/configs/flavor_config.dart';
import 'main.dart' as runner;

Future<void> main() async {
  FlavorConfig(
    flavor: FlavorType.prod,
  );
  await runner.main();
}
