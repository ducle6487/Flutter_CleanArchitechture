import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_response_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/repository/auth_repository.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/refresh_token/refresh_token_usecase.dart';

class RefreshTokenUsecaseImpl implements RefreshTokenUsecase {
  final AuthRepository _authRepository;

  const RefreshTokenUsecaseImpl({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<SignInResponseDTO?> execute() async {
    return await _authRepository.refreshToken();
  }
}
