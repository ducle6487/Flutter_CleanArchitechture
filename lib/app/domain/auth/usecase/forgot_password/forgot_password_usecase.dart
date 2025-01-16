import 'package:Flutter_CleanArchitechture/app/domain/auth/model/forgot_password_request_dto.dart';

abstract interface class ForgotPasswordUsecase {
  Future<void> execute({
    required ForgotPasswordRequestDTO forgotPasswordRequestDTO,
  });
}
