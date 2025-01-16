import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architechture/core/error/enum/client/client_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/model/client_failure.dart';

class ChangePasswordRequestDTO extends Equatable {
  final String password;
  final String passwordNew;
  final String passwordConfirm;

  const ChangePasswordRequestDTO(
    this.password,
    this.passwordNew,
    this.passwordConfirm,
  );

  @override
  List<Object?> get props => [
        password,
        passwordNew,
        passwordConfirm,
      ];

  /// Creates a [ChangePasswordRequestDTO] from [changePasswordRequestDTO].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory ChangePasswordRequestDTO.fromDTO({
    required ChangePasswordRequestDTO changePasswordRequestDTO,
  }) {
    try {
      return ChangePasswordRequestDTO(
        changePasswordRequestDTO.password,
        changePasswordRequestDTO.passwordNew,
        changePasswordRequestDTO.passwordConfirm,
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
        'password': password,
        "passwordNew": passwordNew,
        "passwordConfirm": passwordConfirm,
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
