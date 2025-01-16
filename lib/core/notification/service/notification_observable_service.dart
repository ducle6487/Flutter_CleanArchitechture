import 'package:Flutter_CleanArchitechture/app/presentation/notifications_history/controller/notification_history_view_controller.dart';

class NotificationObservableService {
  static NotificationHistoryViewController? _controller;

  NotificationObservableService._();

  static void createInstance(
      NotificationHistoryViewController notificationHistoryViewController) {
    _controller = notificationHistoryViewController;
  }

  static void isNewNotifications() {
    _controller?.getUnreadNotificationsCount();
  }
}
