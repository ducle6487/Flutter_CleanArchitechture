import 'package:flutter_clean_architechture/app/domain/auth/model/resent_otp_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/auth/repository/auth_repository.dart';
import 'package:flutter_clean_architechture/app/domain/auth/usecase/resent_otp/resent_otp_usecase.dart';

class ResentOTPUsecaseImpl implements ResentOTPUsecase {
  final AuthRepository _authRepository;

  const ResentOTPUsecaseImpl({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<void> execute(
      {required ResentOTPRequestDTO resentOTPRequestDTO}) async {
    return await _authRepository.resentOTP(
      resentOTPRequestDTO: resentOTPRequestDTO,
    );
  }
}
