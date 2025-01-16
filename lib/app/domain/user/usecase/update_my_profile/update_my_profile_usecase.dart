import 'package:Flutter_CleanArchitechture/app/domain/user/model/user_profile_request_dto.dart';
import '../../model/user_profile_response_dto.dart';

abstract interface class UpdateMyProfileUsecase {
  Future<UserProfileResponseDTO?> execute({
    required UserProfileRequestDTO userProfileRequestDTO,
  });
}
