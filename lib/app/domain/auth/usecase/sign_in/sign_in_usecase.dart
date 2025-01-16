import 'package:Flutter_CleanArchitechture/app/domain/auth/model/sign_in_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/sign_in_response_dto.dart';

abstract interface class SignInUsecase {
  Future<SignInResponseDTO?> execute({
    required SignInRequestDTO signInRequestDTO,
  });
}
