import 'package:flutter_clean_architechture/config/main_configs/main_config.dart';
import 'package:flutter_clean_architechture/core/environment/enum/development_environment.dart';

Future<void> main() async {
  await mainCommon(env: Environment.develop);
}
