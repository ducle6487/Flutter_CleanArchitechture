import 'package:equatable/equatable.dart';
import 'package:Flutter_CleanArchitechture/core/error/enum/client/client_exception_type.dart';
import 'package:Flutter_CleanArchitechture/core/error/model/client_failure.dart';

class UserProfileRequestDTO extends Equatable {
  final String? email;
  final String? phone;
  final String? fullName;
  final String? birthDay;
  final bool? gender;
  final String? address;
  final String? avatarUrl;

  const UserProfileRequestDTO({
    this.email,
    this.phone,
    this.fullName,
    this.birthDay,
    this.gender,
    this.address,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [
        email,
        phone,
        fullName,
        birthDay,
        gender,
        address,
        avatarUrl,
      ];

  /// Converts the DTO to JSON.
  ///
  /// Throws a [ClientFailure] when an error occurs.
  Map<String, dynamic> toJson() {
    try {
      final Map<String, dynamic> jsonMap = {};
      if (fullName != null) jsonMap['fullName'] = fullName;
      if (email != null) jsonMap['email'] = email;
      if (phone != null) jsonMap['phone'] = phone;
      if (birthDay != null) jsonMap['birthday'] = birthDay;
      if (gender != null) jsonMap['gender'] = gender;
      if (address != null) jsonMap['address'] = address;
      if (avatarUrl != null) jsonMap['avatarUrl'] = avatarUrl;

      return jsonMap;
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
