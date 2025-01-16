import 'package:flutter_clean_architechture/config/app_resources.dart';

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
