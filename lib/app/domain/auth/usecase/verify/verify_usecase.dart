import 'package:flutter_clean_architechture/app/domain/auth/model/verify_request_dto.dart';

abstract interface class VerifyUsecase {
  Future<void> execute({
    required VerifyRequestDTO verifyRequestDTO,
  });
}
