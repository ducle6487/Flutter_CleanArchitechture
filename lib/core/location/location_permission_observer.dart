import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationPermissionObserver {
  final StreamController<LocationPermission> _permissionStreamController =
      StreamController<LocationPermission>.broadcast();
  Timer? _timer;
  LocationPermission?
      _lastKnownPermission; // Track the last known permission status

  Stream<LocationPermission> get permissionStream =>
      _permissionStreamController.stream;

  LocationPermissionObserver() {
    _checkPermissionStatus(); // Initial check
    _startListeningForChanges(); // Start periodic checks
  }

  // Check the permission status and notify if it has changed
  Future<void> _checkPermissionStatus() async {
    final currentPermission = await Geolocator.checkPermission();
    if (_lastKnownPermission != currentPermission) {
      // Notify listeners if the permission status has changed
      _lastKnownPermission = currentPermission;
      _permissionStreamController.add(currentPermission);
    }
  }

  // Periodically check for permission status changes
  void _startListeningForChanges() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _checkPermissionStatus();
    });
  }

  // Manually trigger permission check (e.g., on button click)
  Future<void> requestPermissionAndCheck() async {
    final currentPermission = await Geolocator.requestPermission();
    if (_lastKnownPermission != currentPermission) {
      // Notify listeners if the permission status has changed
      _lastKnownPermission = currentPermission;
      _permissionStreamController.add(currentPermission);
    }
  }

  void dispose() {
    _timer?.cancel(); // Stop the timer
    _permissionStreamController.close();
  }
}
