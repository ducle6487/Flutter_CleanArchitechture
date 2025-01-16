import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architechture/core/error/enum/client/client_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/model/client_failure.dart';

class ForgotPasswordRequestDTO extends Equatable {
  final String email;
  final bool isVerifiedMail;

  const ForgotPasswordRequestDTO(
    this.email,
    this.isVerifiedMail,
  );

  @override
  List<Object?> get props => [email, isVerifiedMail];

  /// Creates a [ForgotPasswordRequestDTO] from [forgotPasswordRequestDTO].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory ForgotPasswordRequestDTO.fromDTO({
    required ForgotPasswordRequestDTO forgotPasswordRequestDTO,
  }) {
    try {
      return ForgotPasswordRequestDTO(forgotPasswordRequestDTO.email,
          forgotPasswordRequestDTO.isVerifiedMail);
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
        'isVerifiedMail': isVerifiedMail,
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
