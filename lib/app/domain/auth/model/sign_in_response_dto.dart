import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architechture/app/domain/user/model/user_profile_response_dto.dart';
import 'package:flutter_clean_architechture/core/error/enum/client/client_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/model/client_failure.dart';

class SignInResponseDTO extends Equatable {
  final UserProfileResponseDTO? profile;
  final String? accessToken;
  final String? refreshToken;
  final int? statusCode;
  final String? message;
  final String? uuid;

  const SignInResponseDTO({
    required this.profile,
    required this.accessToken,
    required this.refreshToken,
    required this.statusCode,
    required this.uuid,
    required this.message,
  });

  @override
  List<Object?> get props => [profile, accessToken, refreshToken, uuid];

  /// Creates a [SignInResponseDTO] from [signInResponseDTO].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory SignInResponseDTO.fromDTO(
      {required SignInResponseDTO signInResponseDTO}) {
    try {
      return SignInResponseDTO(
        profile: signInResponseDTO.profile,
        accessToken: signInResponseDTO.accessToken,
        refreshToken: signInResponseDTO.refreshToken,
        statusCode: signInResponseDTO.statusCode,
        uuid: signInResponseDTO.uuid,
        message: signInResponseDTO.message,
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

  /// Creates an [SignInResponseDTO] from [json].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory SignInResponseDTO.fromJson({
    required Map<String, dynamic> json,
    int? statusCode,
  }) {
    try {
      return SignInResponseDTO(
        profile: json['profile'] == null && json['user'] == null
            ? null
            : UserProfileResponseDTO.fromJson(
                json: json['profile'] ?? json['user']),
        accessToken: json['accessToken']?.toString(),
        refreshToken: json['refreshToken']?.toString(),
        statusCode: statusCode ?? json['statusCode'],
        uuid: json['uuid'],
        message: json['message'],
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
