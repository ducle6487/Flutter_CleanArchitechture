import 'package:equatable/equatable.dart';
import 'package:Flutter_CleanArchitechture/core/api/model/pagination.dart';
import 'package:Flutter_CleanArchitechture/core/error/enum/client/client_exception_type.dart';
import 'package:Flutter_CleanArchitechture/core/error/model/client_failure.dart';

class PaginationWrapperDTO<T> extends Equatable {
  final T? data;
  final PaginationDTO? pagination;

  const PaginationWrapperDTO({
    this.data,
    this.pagination,
  });

  @override
  List<Object?> get props => [
        data,
        pagination,
      ];

  factory PaginationWrapperDTO.withData({
    required Map<String, dynamic> json,
    T? data,
  }) {
    try {
      // Parse pagination data
      final paginationData = json['pagination'];
      final pagination = PaginationDTO.fromJson(json: paginationData);

      return PaginationWrapperDTO(
        data: data,
        pagination: pagination,
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unexpectedDataTypeException,
      );
    }
  }
}
