import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_architechture/core/firebase/firebase_messaging_service.dart';
import 'package:flutter_clean_architechture/core/storage/service/shared_preference_service.dart';
import '../../router/enum/router_type.dart';

class AuthorizationService {
  AuthorizationService._();

// Singleton instance
  static final AuthorizationService _instance = AuthorizationService._();

  // Public getter to access the singleton instance
  static AuthorizationService get instance => _instance;

  bool isRefreshingToken = false;

  bool get isAuthorized => (_getAccessToken() ?? '').isNotEmpty;

  String get accessToken => (_getAccessToken() ?? '');

  String get refreshToken => (_getRefreshToken() ?? '');

  set accessToken(String? accessToken) => _saveToken(accessToken, null);

  set refreshToken(String? refreshToken) => _saveToken(null, refreshToken);

  void clearToken({
    bool? isNotPop,
  }) {
    SharedPreferenceService.clearToken();
    FirebaseMessagingService.shared.userRequestLogout();
    if (isNotPop == null || !isNotPop) {
      Get.context?.goNamed(RouterType.welcome.name);
    }
  }

  String? _getAccessToken() {
    return SharedPreferenceService.getAccessToken();
  }

  void _saveToken(String? accessToken, String? refreshToken) {
    if (accessToken != null) {
      SharedPreferenceService.setAccessToken(accessToken: accessToken);
    }
    if (refreshToken != null) {
      SharedPreferenceService.setRefreshToken(refreshToken: refreshToken);
    }
  }

  String? _getRefreshToken() {
    return SharedPreferenceService.getRefreshToken();
  }
}
