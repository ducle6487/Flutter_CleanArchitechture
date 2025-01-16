import 'package:equatable/equatable.dart';
import 'package:Flutter_CleanArchitechture/core/error/enum/client/client_exception_type.dart';
import 'package:Flutter_CleanArchitechture/core/error/model/client_failure.dart';

class ResentOTPRequestDTO extends Equatable {
  final String email;
  final String uuid;

  const ResentOTPRequestDTO(
    this.email,
    this.uuid,
  );

  @override
  List<Object?> get props => [email, uuid];

  /// Creates a [ResentOTPRequestDTO] from [resentOTPRequestDTO].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory ResentOTPRequestDTO.fromDTO(
      {required ResentOTPRequestDTO resentOTPRequestDTO}) {
    try {
      return ResentOTPRequestDTO(
          resentOTPRequestDTO.email, resentOTPRequestDTO.uuid);
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
        'email': email,
        'uuid': uuid,
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
