import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_response_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/repository/auth_repository.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/sign_in/sign_in_usecase.dart';

class SignInUsecaseImpl implements SignInUsecase {
  final AuthRepository _authRepository;

  const SignInUsecaseImpl({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<SignInResponseDTO?> execute({
    required SignInRequestDTO signInRequestDTO,
  }) async {
    return await _authRepository.signIn(
      signInRequestDTO: signInRequestDTO,
    );
  }
}
