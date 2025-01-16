import 'package:Flutter_CleanArchitechture/core/environment/enum/development_environment.dart';
import 'main_config.dart';

Future<void> main() async {
  await mainCommon(env: Environment.develop);
}
