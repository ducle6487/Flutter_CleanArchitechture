import 'package:flutter_clean_architechture/app/domain/auth/model/forgot_password_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/repository/auth_repository.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/forgot_password/forgot_password_usecase.dart';

class ForgoPasswordUsecaseImpl implements ForgotPasswordUsecase {
  final AuthRepository _authRepository;

  const ForgoPasswordUsecaseImpl({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<void> execute({
    required ForgotPasswordRequestDTO forgotPasswordRequestDTO,
  }) async {
    return await _authRepository.forgotPassword(
      forgotPasswordRequestDTO: forgotPasswordRequestDTO,
    );
  }
}
