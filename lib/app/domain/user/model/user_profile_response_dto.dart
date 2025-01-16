import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architechture/app/domain/user/model/user_profile_info_response_dto.dart';
import 'package:flutter_clean_architechture/core/error/enum/client/client_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/model/client_failure.dart';

class UserProfileResponseDTO extends Equatable {
  final String? uuid;
  final String? email;
  final String? phone;
  final String? fullname;
  final UserProfileInfoResponseDTO? profile;

  const UserProfileResponseDTO({
    required this.email,
    required this.phone,
    required this.fullname,
    required this.uuid,
    required this.profile,
  });

  @override
  List<Object?> get props => [email, phone, fullname];

  /// Creates a [userProfileResponseDTO] from [userProfileResponseDTO].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory UserProfileResponseDTO.fromDTO(
      {required UserProfileResponseDTO userProfileResponseDTO}) {
    try {
      return UserProfileResponseDTO(
        uuid: userProfileResponseDTO.uuid,
        email: userProfileResponseDTO.email,
        phone: userProfileResponseDTO.phone,
        fullname: userProfileResponseDTO.fullname,
        profile: userProfileResponseDTO.profile,
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

  /// Creates an [UserProfileResponseDTO] from [json].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory UserProfileResponseDTO.fromJson(
      {required Map<String, dynamic> json}) {
    try {
      return UserProfileResponseDTO(
        uuid: json['uuid']?.toString(),
        email: json['email']?.toString(),
        phone: json['phone']?.toString(),
        fullname: json['fullName']?.toString(),
        profile: json['profile'] == null
            ? null
            : UserProfileInfoResponseDTO.fromJson(json: json['profile']),
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
