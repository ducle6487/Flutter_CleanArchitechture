import 'package:flutter_clean_architechture/app/domain/user/repository/user_repository.dart';
import 'package:flutter_clean_architechture/app/domain/user/usecase/delete_account/delete_account_usecase.dart.dart';

class DeleteAccountUsecaseImpl implements DeleteAccountUsecase {
  final UserRepository _userRepository;

  const DeleteAccountUsecaseImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<void> excute() async {
    return await _userRepository.deleteAccount();
  }
}
