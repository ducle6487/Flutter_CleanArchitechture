import 'package:flutter_clean_architechture/app/domain/user/model/user_profile_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/user/repository/user_repository.dart';
import 'package:flutter_clean_architechture/app/domain/user/usecase/update_my_profile/update_my_profile_usecase.dart';
import '../../model/user_profile_response_dto.dart';

class UpdateMyProfileUsecaseImpl implements UpdateMyProfileUsecase {
  final UserRepository _userRepository;

  const UpdateMyProfileUsecaseImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<UserProfileResponseDTO?> execute({
    required UserProfileRequestDTO userProfileRequestDTO,
  }) async {
    return await _userRepository.updateMyProfile(
      userProfileRequestDTO: userProfileRequestDTO,
    );
  }
}
