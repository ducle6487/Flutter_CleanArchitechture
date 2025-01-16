import 'package:Flutter_CleanArchitechture/app/domain/auth/repository/auth_repository.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/usecase/sign_out/sign_out_usecase.dart';

class SignOutUsecaseImpl implements SignOutUsecase {
  final AuthRepository _authRepository;

  const SignOutUsecaseImpl({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<void> execute() async {
    return await _authRepository.signOut();
  }
}
