import 'package:flutter_clean_architechture/app/domain/auth/model/forgot_password_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/resent_otp_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_response_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_up_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/verify_request_dto.dart';

abstract interface class AuthRemoteDataSource {
  Future<SignInResponseDTO?> signIn({
    required SignInRequestDTO signInRequestDTO,
  });

  Future<SignInResponseDTO?> signUp({
    required SignUpRequestDTO signUpRequestDTO,
  });

  Future<void> verify({
    required VerifyRequestDTO verifyRequestDTO,
  });

  Future<void> resendOTP({
    required ResentOTPRequestDTO resentOTPRequestDTO,
  });

  Future<void> forgotPassword({
    required ForgotPasswordRequestDTO forgotPasswordRequestDTO,
  });

  Future<void> signOut();

  Future<SignInResponseDTO?> refreshToken();
}
