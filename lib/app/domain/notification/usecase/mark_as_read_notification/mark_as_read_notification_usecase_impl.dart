import 'package:flutter_clean_architechture/app/domain/notification/repository/notification_repository.dart';
import 'package:flutter_clean_architechture/app/domain/notification/usecase/mark_as_read_notification/mark_as_read_notification_usecase.dart';

class MarkAsReadNotificationUsecaseImpl
    implements MarkAsReadNotificationUsecase {
  final NotificationRepository _notificationRepository;

  const MarkAsReadNotificationUsecaseImpl({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  @override
  Future<void> execute({
    required String notificationId,
  }) async {
    return await _notificationRepository.markAsReadNotification(
      notificationId: notificationId,
    );
  }
}
