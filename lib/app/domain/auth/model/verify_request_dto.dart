import 'package:equatable/equatable.dart';
import 'package:Flutter_CleanArchitechture/core/error/enum/client/client_exception_type.dart';
import 'package:Flutter_CleanArchitechture/core/error/model/client_failure.dart';

class VerifyRequestDTO extends Equatable {
  final String uuid;
  final String otp;

  const VerifyRequestDTO(
    this.uuid,
    this.otp,
  );

  @override
  List<Object?> get props => [uuid, otp];

  /// Creates a [VerifyRequestDTO] from [verifyRequestDTO].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory VerifyRequestDTO.fromDTO(
      {required VerifyRequestDTO verifyRequestDTO}) {
    try {
      return VerifyRequestDTO(
        verifyRequestDTO.uuid,
        verifyRequestDTO.otp,
      );
    } on ClientFailure {
      rethrow;
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unexpectedDataTypeException,
      );
    }
  }

  /// Converts the DTO to JSON.
  ///
  /// Throws a [ClientFailure] when an error occurs.
  Map<String, dynamic> toJson() {
    try {
      return {
        'uuid': uuid,
        'otp': otp,
      };
    } on ClientFailure {
      rethrow;
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unexpectedDataTypeException,
      );
    }
  }
}
