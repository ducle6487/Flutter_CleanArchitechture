import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_clean_architechture/core/environment/enum/development_environment.dart';

class EnvironmentService {
  const EnvironmentService._();

  static void load({
    required Environment env,
  }) async {
    switch (env) {
      case Environment.develop:
        await dotenv.load(fileName: 'assets/env/.env.develop');
      case Environment.staging:
        await dotenv.load(fileName: 'assets/env/.env.staging');
      default:
        await dotenv.load(fileName: 'assets/env/.env.production');
    }
  }

  static String get apiUrl {
    return dotenv.env['API_URL'] ?? 'API_URL not found!';
  }

  static String get orgId {
    return dotenv.env['ORG_ID'] ?? 'ORG_ID not found!';
  }
}
