import 'package:Flutter_CleanArchitechture/config/main_configs/main_config.dart';
import 'package:Flutter_CleanArchitechture/core/environment/enum/development_environment.dart';

Future<void> main() async {
  await mainCommon(env: Environment.develop);
}
