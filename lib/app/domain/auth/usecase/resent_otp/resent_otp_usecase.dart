import 'package:Flutter_CleanArchitechture/app/domain/auth/model/resent_otp_request_dto.dart';

abstract interface class ResentOTPUsecase {
  Future<void> execute({
    required ResentOTPRequestDTO resentOTPRequestDTO,
  });
}
