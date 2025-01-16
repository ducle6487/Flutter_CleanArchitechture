import 'package:Flutter_CleanArchitechture/app/domain/auth/model/change_password_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/repository/user_repository.dart';
import 'change_password_usecase.dart';

class ChangePasswordUsecaseImpl implements ChangePasswordUsecase {
  final UserRepository _userRepository;

  const ChangePasswordUsecaseImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<void> execute({
    required ChangePasswordRequestDTO changePasswordRequestDTO,
  }) async {
    return await _userRepository.changePassword(
      changePasswordRequestDTO: changePasswordRequestDTO,
    );
  }
}
