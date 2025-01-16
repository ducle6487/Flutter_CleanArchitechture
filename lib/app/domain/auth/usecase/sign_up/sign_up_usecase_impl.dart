import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_response_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_up_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/repository/auth_repository.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/sign_up/sign_up_usecase.dart';

class SignUpUsecaseImpl implements SignUpUsecase {
  final AuthRepository _authRepository;

  const SignUpUsecaseImpl({
    required AuthRepository userRepository,
  }) : _authRepository = userRepository;

  @override
  Future<SignInResponseDTO?> execute(
      {required SignUpRequestDTO signUpRequestDTO}) async {
    return await _authRepository.signUp(
      signUpRequestDTO: signUpRequestDTO,
    );
  }
}
