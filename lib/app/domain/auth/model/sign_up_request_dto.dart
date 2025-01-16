import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architechture/app/domain/auth/enum/role_code.dart';
import 'package:flutter_clean_architechture/core/error/enum/client/client_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/model/client_failure.dart';

class SignUpRequestDTO extends Equatable {
  final int orgId;
  final String email;
  final String password;
  final String phone;
  final String? address;
  final bool? gender;
  final DateTime? birthDay;

  const SignUpRequestDTO(
    this.orgId,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.gender,
    this.birthDay,
  );

  @override
  List<Object?> get props =>
      [email, password, phone, address, gender, birthDay];

  /// Creates a [SignUpRequestDTO] from [signUpRequestDTO].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory SignUpRequestDTO.fromDTO(
      {required SignUpRequestDTO signUpRequestDTO}) {
    try {
      return SignUpRequestDTO(
        signUpRequestDTO.orgId,
        signUpRequestDTO.email,
        signUpRequestDTO.password,
        signUpRequestDTO.phone,
        signUpRequestDTO.address,
        signUpRequestDTO.gender,
        signUpRequestDTO.birthDay,
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
        'orgId': orgId,
        'email': email,
        'password': password,
        'phone': phone,
        if (address != null) 'address': address,
        if (gender != null) 'gender': gender,
        if (birthDay != null) 'birthday': birthDay!.toIso8601String(),
        'roleCode': RoleCode.user.value,
        'isVerifiedMail': true,
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
