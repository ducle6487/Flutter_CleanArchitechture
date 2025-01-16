import 'package:Flutter_CleanArchitechture/config/app_resources.dart';

enum UserEndPoint {
  me('/me'),
  updatePassword('/me/update-password/change'),
  registerFCM('/enable'),
  partnerServicesList("/partner/service/me"),
  serviceExpertDetail("/partner/service/detail/me/"),
  healthTracking("/health/tracking"),
  removeAccount("/account/me"),
  ;

  final String value;
  const UserEndPoint(this.value);

  String getUrl() {
    return AppResources.userBaseUrl + value;
  }
}
