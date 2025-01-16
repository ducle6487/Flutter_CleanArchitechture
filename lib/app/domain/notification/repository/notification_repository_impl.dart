import 'package:Flutter_CleanArchitechture/app/data/notification/source/remote/notification_remote_data_source.dart';
import 'package:Flutter_CleanArchitechture/core/api/model/pagination_wrapper_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/repository/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _notificationRemoteDataSource;

  const NotificationRepositoryImpl({
    required NotificationRemoteDataSource notificationRemoteDataSource,
  }) : _notificationRemoteDataSource = notificationRemoteDataSource;

  @override
  Future<PaginationWrapperDTO?> getNotificationHistory() async {
    return await _notificationRemoteDataSource.getNotificationHistory();
  }

  @override
  Future<PaginationWrapperDTO?> loadMoreNotificationHistory({
    required int? page,
  }) async {
    return await _notificationRemoteDataSource.loadMoreNotificationHistory(
      page: page,
    );
  }

  @override
  Future<void> markAsReadNotification({
    required String notificationId,
  }) async {
    return await _notificationRemoteDataSource.markAsReadNotification(
      notificationId: notificationId,
    );
  }

  @override
  Future<int> getUnreadNotificationsCount() async {
    return await _notificationRemoteDataSource.getUnReadNotificationsCount();
  }

  @override
  Future<void> clearNewNotification() async {
    return await _notificationRemoteDataSource.clearNewNotification();
  }
}
