import 'package:Flutter_CleanArchitechture/core/api/model/pagination_wrapper_dto.dart';

abstract interface class NotificationRemoteDataSource {
  Future<PaginationWrapperDTO?> getNotificationHistory();

  Future<PaginationWrapperDTO?> loadMoreNotificationHistory({
    required int? page,
  });

  Future<void> markAsReadNotification({
    required String notificationId,
  });

  Future<int> getUnReadNotificationsCount();

  Future<void> clearNewNotification();
}
