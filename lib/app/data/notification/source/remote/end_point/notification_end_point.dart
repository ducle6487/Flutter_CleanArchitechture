import 'package:Flutter_CleanArchitechture/config/app_resources.dart';

enum NotificationEndPoint {
  getNotificationHistory(''),
  markAsReadNotification('/'),
  getUnReadNotificationsCount('/count'),
  clearNewNotification('/seen');

  final String value;
  const NotificationEndPoint(this.value);

  String getUrl() {
    return AppResources.notificationBaseUrl + value;
  }
}
