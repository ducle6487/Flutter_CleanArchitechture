import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/data/auth/provider/auth_data_provider.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/forgot_password/forgot_password_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/forgot_password/forgot_password_usecase_impl.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/refresh_token/refresh_token_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/refresh_token/refresh_token_usecase_impl.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/resent_otp/resent_otp_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/resent_otp/resent_otp_usecase_impl.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/sign_in/sign_in_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/sign_in/sign_in_usecase_impl.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/sign_out/sign_out_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/sign_out/sign_out_usecase_impl.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/sign_up/sign_up_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/sign_up/sign_up_usecase_impl.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/verify/verify_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/verify/verify_usecase_impl.dart';

class AuthDomainProvider {
  const AuthDomainProvider._();

  /// Provider for [SignInUsecase].
  static final signInUsecaseProvider = Provider<SignInUsecase>(
    (ref) {
      return SignInUsecaseImpl(
        authRepository: ref.watch(
          AuthDataProvider.authRepositoryProvider,
        ),
      );
    },
  );

  static final signUpUsecaseProvider = Provider<SignUpUsecase>(
    (ref) {
      return SignUpUsecaseImpl(
        userRepository: ref.watch(
          AuthDataProvider.authRepositoryProvider,
        ),
      );
    },
  );

  static final verifyUsecaseProvider = Provider<VerifyUsecase>(
    (ref) {
      return VerifyUsecaseImpl(
        authRepository: ref.watch(
          AuthDataProvider.authRepositoryProvider,
        ),
      );
    },
  );

  static final resentOTPUsecaseProvider = Provider<ResentOTPUsecase>(
    (ref) {
      return ResentOTPUsecaseImpl(
        authRepository: ref.watch(AuthDataProvider.authRepositoryProvider),
      );
    },
  );

  static final signOutUsecaseProvider = Provider<SignOutUsecase>(
    (ref) {
      return SignOutUsecaseImpl(
        authRepository: ref.watch(AuthDataProvider.authRepositoryProvider),
      );
    },
  );

  static final forgotPasswordUsecaseProvider = Provider<ForgotPasswordUsecase>(
    (ref) {
      return ForgoPasswordUsecaseImpl(
        authRepository: ref.watch(AuthDataProvider.authRepositoryProvider),
      );
    },
  );

  static final refreshTokenUsecaseProvider = Provider<RefreshTokenUsecase>(
    (ref) {
      return RefreshTokenUsecaseImpl(
        authRepository: ref.watch(AuthDataProvider.authRepositoryProvider),
      );
    },
  );
}
