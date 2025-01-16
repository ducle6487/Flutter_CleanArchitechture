import 'package:flutter_clean_architechture/app/domain/auth/model/change_password_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/user/model/user_profile_request_dto.dart';
import 'package:flutter_clean_architechture/app/domain/user/model/user_profile_response_dto.dart';

abstract interface class UserRepository {
  Future<UserProfileResponseDTO?> getMyProfile();

  Future<UserProfileResponseDTO?> updateMyProfile({
    required UserProfileRequestDTO userProfileRequestDTO,
  });

  Future<void> changePassword({
    required ChangePasswordRequestDTO changePasswordRequestDTO,
  });

  Future<void> deleteAccount();
}
