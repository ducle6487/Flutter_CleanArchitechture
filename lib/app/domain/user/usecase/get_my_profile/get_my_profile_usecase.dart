import 'package:Flutter_CleanArchitechture/app/domain/user/model/user_profile_response_dto.dart';

abstract interface class GetMyProfileUsecase {
  Future<UserProfileResponseDTO?> execute();
}
