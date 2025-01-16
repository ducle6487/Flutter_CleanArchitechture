import 'package:flutter_clean_architechture/app/domain/notification/usecase/clear_new_notification/clear_new_notification_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/notification/repository/notification_repository.dart';

class ClearNewNotificationUsecaseImpl implements ClearNewNotificationUsecase {
  final NotificationRepository _notificationRepository;

  const ClearNewNotificationUsecaseImpl({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  @override
  Future<void> execute() async {
    return await _notificationRepository.clearNewNotification();
  }
}
