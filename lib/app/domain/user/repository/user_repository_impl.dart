import 'package:Flutter_CleanArchitechture/app/data/user/source/remote/user_remote_data_source.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/change_password_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/model/user_profile_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/model/user_profile_response_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  const UserRepositoryImpl({
    required UserRemoteDataSource userRemoteDataSource,
  }) : _userRemoteDataSource = userRemoteDataSource;

  @override
  Future<UserProfileResponseDTO?> getMyProfile() async {
    return await _userRemoteDataSource.getMyProfile();
  }

  @override
  Future<UserProfileResponseDTO?> updateMyProfile({
    required UserProfileRequestDTO userProfileRequestDTO,
  }) async {
    return await _userRemoteDataSource.updateMyProfile(
      userProfileRequestDTO: userProfileRequestDTO,
    );
  }

  @override
  Future<void> changePassword({
    required ChangePasswordRequestDTO changePasswordRequestDTO,
  }) async {
    return await _userRemoteDataSource.changePassword(
      changePasswordRequestDTO: changePasswordRequestDTO,
    );
  }

  @override
  Future<void> deleteAccount() async {
    return await _userRemoteDataSource.deleteAccount();
  }
}
