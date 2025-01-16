import 'package:flutter_clean_architechture/app/domain/user/model/user_profile_response_dto.dart';

abstract interface class GetMyProfileUsecase {
  Future<UserProfileResponseDTO?> execute();
}
