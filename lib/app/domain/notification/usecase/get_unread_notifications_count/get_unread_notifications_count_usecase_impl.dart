import 'package:Flutter_CleanArchitechture/app/domain/notification/repository/notification_repository.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/usecase/get_unread_notifications_count/get_unread_notifications_count_usecase.dart';

class GetUnreadNotificationsCountUsecaseImpl
    implements GetUnreadNotificationsCountUsecase {
  final NotificationRepository _notificationRepository;

  const GetUnreadNotificationsCountUsecaseImpl({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  @override
  Future<int> execute() async {
    return await _notificationRepository.getUnreadNotificationsCount();
  }
}
