import 'package:Flutter_CleanArchitechture/core/api/model/pagination_wrapper_dto.dart';

abstract interface class NotificationRepository {
  Future<PaginationWrapperDTO?> getNotificationHistory();

  Future<PaginationWrapperDTO?> loadMoreNotificationHistory({
    required int? page,
  });

  Future<void> markAsReadNotification({
    required String notificationId,
  });

  Future<int> getUnreadNotificationsCount();

  Future<void> clearNewNotification();
}
