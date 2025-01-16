import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionService {
  static List<ConnectivityResult> _connectionStatus = [];
  static Future<void> initializeConnectivity() async {
    Connectivity().onConnectivityChanged.listen((result) {
      _connectionStatus = result;
    });
  }

  static bool isDisconnected() {
    return _connectionStatus.contains(ConnectivityResult.none);
  }
}
