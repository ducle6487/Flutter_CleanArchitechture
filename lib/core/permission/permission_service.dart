import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> requestLocationPermissions() async {
    await Permission.location.request();
  }
}
