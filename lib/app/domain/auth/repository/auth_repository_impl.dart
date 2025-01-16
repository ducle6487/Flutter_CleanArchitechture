import 'package:flutter_clean_architechture/app/data/auth/source/remote/auth_remote_data_source.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/forgot_password_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/resent_otp_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_response_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_up_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/verify_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  const AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
  }) : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<SignInResponseDTO?> signIn({
    required SignInRequestDTO signInRequestDTO,
  }) async {
    return await _authRemoteDataSource.signIn(
        signInRequestDTO: signInRequestDTO);
  }

  @override
  Future<SignInResponseDTO?> signUp({
    required SignUpRequestDTO signUpRequestDTO,
  }) async {
    return await _authRemoteDataSource.signUp(
      signUpRequestDTO: signUpRequestDTO,
    );
  }

  @override
  Future<void> verify({
    required VerifyRequestDTO verifyRequestDTO,
  }) async {
    return await _authRemoteDataSource.verify(
      verifyRequestDTO: verifyRequestDTO,
    );
  }

  @override
  Future<void> resentOTP({
    required ResentOTPRequestDTO resentOTPRequestDTO,
  }) async {
    return await _authRemoteDataSource.resendOTP(
      resentOTPRequestDTO: resentOTPRequestDTO,
    );
  }

  @override
  Future<void> signOut() async {
    return await _authRemoteDataSource.signOut();
  }

  @override
  Future<SignInResponseDTO?> refreshToken() async {
    return await _authRemoteDataSource.refreshToken();
  }

  @override
  Future<void> forgotPassword({
    required ForgotPasswordRequestDTO forgotPasswordRequestDTO,
  }) async {
    return await _authRemoteDataSource.forgotPassword(
      forgotPasswordRequestDTO: forgotPasswordRequestDTO,
    );
  }
}
