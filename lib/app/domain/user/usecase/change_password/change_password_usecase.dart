import 'package:Flutter_CleanArchitechture/app/domain/auth/model/change_password_request_dto.dart';

abstract interface class ChangePasswordUsecase {
  Future<void> execute({
    required ChangePasswordRequestDTO changePasswordRequestDTO,
  });
}
