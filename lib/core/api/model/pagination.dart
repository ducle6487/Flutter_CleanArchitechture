import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architechture/core/error/enum/client/client_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/model/client_failure.dart';

class PaginationDTO extends Equatable {
  final int? total;
  final int? limit;
  final int? offset;
  final int? nextPage;

  const PaginationDTO({
    this.limit,
    this.offset,
    this.total,
    this.nextPage,
  });

  @override
  List<Object?> get props => [
        total,
        limit,
        offset,
        nextPage,
      ];

  factory PaginationDTO.fromJson({
    required Map<String, dynamic> json,
  }) {
    try {
      return PaginationDTO(
        total: json['total'],
        limit: json['limit'],
        offset: json['offset'],
        nextPage: json['nextPage'],
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
