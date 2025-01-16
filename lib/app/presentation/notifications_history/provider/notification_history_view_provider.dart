import 'package:Flutter_CleanArchitechture/app/domain/notification/provider/notification_domain_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/notifications_history/controller/notification_history_view_controller.dart';

class NotificationHistoryViewProvider {
  const NotificationHistoryViewProvider._();

  /// Provider for [NotificationHistoryViewController].
  static final notificationHistoryViewControllerProvider =
      StateNotifierProvider<NotificationHistoryViewController,
          NotificationHistoryViewState>(
    (ref) {
      return NotificationHistoryViewController(
        getNotificationHistoryUsecase: ref.watch(
          NotificationDomainProvider.getNotificationHistoryUsecaseProvider,
        ),
        loadmoreNotificationHistoryUsecase: ref.watch(
          NotificationDomainProvider.loadmoreNotificationHistoryUsecaseProvider,
        ),
        markAsReadNotificationUsecase: ref.watch(
          NotificationDomainProvider.markAsReadNotificationUsecaseProvider,
        ),
        getUnreadNotificationsCountUsecase: ref.watch(
          NotificationDomainProvider.getUnreadNotificationsCountUsecaseProvider,
        ),
        clearNewNotificationUsecase: ref.watch(
          NotificationDomainProvider.clearNewNotificationUsecaseProvider,
        ),
      );
    },
  );
}
