import 'package:flutter_clean_architechture/app/domain/auth/model/verify_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/repository/auth_repository.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/verify/verify_usecase.dart';

class VerifyUsecaseImpl implements VerifyUsecase {
  final AuthRepository _authRepository;

  const VerifyUsecaseImpl({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<void> execute({required VerifyRequestDTO verifyRequestDTO}) async {
    return await _authRepository.verify(
      verifyRequestDTO: verifyRequestDTO,
    );
  }
}
