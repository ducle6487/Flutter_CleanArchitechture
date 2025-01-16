import 'package:flutter_clean_architechture/core/api/model/pagination_wrapper_dto.dart';
import 'package:flutter_clean_architechture/app/domain/notification/repository/notification_repository.dart';
import 'package:flutter_clean_architechture/app/domain/notification/usecase/loadmore_notification_history/loadmore_notification_history_usecase.dart';

class LoadmoreNotificationHistoryUsecaseImpl
    implements LoadmoreNotificationHistoryUsecase {
  final NotificationRepository _notificationRepository;

  const LoadmoreNotificationHistoryUsecaseImpl({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  @override
  Future<PaginationWrapperDTO?> execute({
    required int? page,
  }) async {
    return await _notificationRepository.loadMoreNotificationHistory(
      page: page,
    );
  }
}
