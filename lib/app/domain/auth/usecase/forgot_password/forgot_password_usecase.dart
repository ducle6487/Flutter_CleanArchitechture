import 'package:flutter_clean_architechture/app/domain/auth/model/forgot_password_request_dto.dart';

abstract interface class ForgotPasswordUsecase {
  Future<void> execute({
    required ForgotPasswordRequestDTO forgotPasswordRequestDTO,
  });
}
