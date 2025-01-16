import 'package:flutter_clean_architechture/core/environment/enum/development_environment.dart';
import 'main_config.dart';

Future<void> main() async {
  await mainCommon(env: Environment.develop);
}
