import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architechture/core/error/enum/client/client_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/model/client_failure.dart';

class SignInRequestDTO extends Equatable {
  final String username;
  final String password;

  const SignInRequestDTO(
    this.username,
    this.password,
  );

  @override
  List<Object?> get props => [username, password];

  /// Creates a [SignInRequestDTO] from [signInRequestDTO].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory SignInRequestDTO.fromDTO(
      {required SignInRequestDTO signInRequestDTO}) {
    try {
      return SignInRequestDTO(
          signInRequestDTO.username, signInRequestDTO.password);
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
        'username': username,
        'password': password,
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
