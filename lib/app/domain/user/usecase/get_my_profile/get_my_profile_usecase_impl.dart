import 'package:Flutter_CleanArchitechture/app/domain/user/model/user_profile_response_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/repository/user_repository.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/usecase/get_my_profile/get_my_profile_usecase.dart';

class GetMyProfileUsecaseImpl implements GetMyProfileUsecase {
  final UserRepository _userRepository;

  const GetMyProfileUsecaseImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<UserProfileResponseDTO?> execute() async {
    return await _userRepository.getMyProfile();
  }
}
