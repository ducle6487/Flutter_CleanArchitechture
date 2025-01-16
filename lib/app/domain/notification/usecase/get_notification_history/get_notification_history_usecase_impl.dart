import 'package:Flutter_CleanArchitechture/core/api/model/pagination_wrapper_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/repository/notification_repository.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/usecase/get_notification_history/get_notification_history_usecase.dart';

class GetNotificationHistoryUsecaseImpl
    implements GetNotificationHistoryUsecase {
  final NotificationRepository _notificationRepository;

  const GetNotificationHistoryUsecaseImpl({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  @override
  Future<PaginationWrapperDTO?> execute() async {
    return await _notificationRepository.getNotificationHistory();
  }
}
