import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architechture/core/error/enum/client/client_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/model/client_failure.dart';

class UserProfileInfoResponseDTO extends Equatable {
  final String? email;
  final String? fullName;
  final String? avatarUrl;
  final bool? gender;
  final String? birthDay;
  final String? address;
  final String? workPlace;
  final String? job;

  const UserProfileInfoResponseDTO({
    this.email,
    required this.fullName,
    required this.gender,
    required this.job,
    required this.address,
    required this.workPlace,
    required this.avatarUrl,
    required this.birthDay,
  });

  @override
  List<Object?> get props => [
        email,
        avatarUrl,
        gender,
        fullName,
        birthDay,
        address,
        workPlace,
        job,
      ];

  /// Creates a [UserProfileInfoResponseDTO] from [userProfileInfoResponseDTO].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory UserProfileInfoResponseDTO.fromDTO(
      {required UserProfileInfoResponseDTO userProfileInfoResponseDTO}) {
    try {
      return UserProfileInfoResponseDTO(
        email: userProfileInfoResponseDTO.email,
        fullName: userProfileInfoResponseDTO.fullName,
        gender: userProfileInfoResponseDTO.gender,
        job: userProfileInfoResponseDTO.job,
        address: userProfileInfoResponseDTO.address,
        workPlace: userProfileInfoResponseDTO.workPlace,
        avatarUrl: userProfileInfoResponseDTO.avatarUrl,
        birthDay: userProfileInfoResponseDTO.birthDay,
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

  /// Creates an [UserProfileInfoResponseDTO] from [json].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory UserProfileInfoResponseDTO.fromJson(
      {required Map<String, dynamic> json}) {
    try {
      return UserProfileInfoResponseDTO(
        email: json['email'],
        fullName: json['fullName'],
        gender: json['gender'],
        job: json['job'],
        address: json['address'],
        workPlace: json['workplace'],
        avatarUrl: json['avatarUrl'],
        birthDay: json['birthday'],
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unexpectedDataTypeException,
      );
    }
  }

  /// Converts [UserProfileInfoResponseDTO] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      'gender': gender,
      'job': job,
      'address': address,
      'workplace': workPlace,
      'avatarUrl': avatarUrl,
      'birthday': birthDay,
    };
  }
}
