import 'package:Flutter_CleanArchitechture/core/api/model/pagination_wrapper_dto.dart';

abstract interface class LoadmoreNotificationHistoryUsecase {
  Future<PaginationWrapperDTO?> execute({
    required int? page,
  });
}
