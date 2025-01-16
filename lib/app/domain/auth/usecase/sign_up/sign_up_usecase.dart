import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_response_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_up_request_dto.dart';

abstract interface class SignUpUsecase {
  Future<SignInResponseDTO?> execute({
    required SignUpRequestDTO signUpRequestDTO,
  });
}
