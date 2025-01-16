import 'package:flutter_clean_architechture/core/api/model/pagination_wrapper_dto.dart';

abstract interface class GetNotificationHistoryUsecase {
  Future<PaginationWrapperDTO?> execute();
}
