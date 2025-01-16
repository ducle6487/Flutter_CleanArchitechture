import 'package:dio/dio.dart';
import 'package:Flutter_CleanArchitechture/app/data/user/source/remote/end_point/user_end_point.dart';
import 'package:Flutter_CleanArchitechture/app/data/user/source/remote/user_remote_data_source.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/change_password_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/model/user_profile_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/model/user_profile_response_dto.dart';
import 'package:Flutter_CleanArchitechture/core/api/enum/status_code.dart';
import 'package:Flutter_CleanArchitechture/core/api/service/http_service.dart';
import 'package:Flutter_CleanArchitechture/core/error/model/server_failure.dart';
import 'package:Flutter_CleanArchitechture/core/log/extension/log_extension.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl({
    required HttpService httpService,
  }) : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<UserProfileResponseDTO?> getMyProfile() async {
    final String url = UserEndPoint.me.getUrl();

    final Response<dynamic> response = await _httpService.getRequest(url: url);

    if (response.statusCode == StatusCode.ok.code) {
      StackTrace.current.printSuccessMessage(
          message: "Parsing API response: \n${response.data}");
    } else {
      throw ServerFailure.fromResponseData(
        response: response,
        stackTrace: StackTrace.current,
      );
    }

    return UserProfileResponseDTO.fromJson(json: response.data['data']);
  }

  @override
  Future<UserProfileResponseDTO?> updateMyProfile({
    required UserProfileRequestDTO userProfileRequestDTO,
  }) async {
    final String url = UserEndPoint.me.getUrl();

    final Map<String, dynamic> data = userProfileRequestDTO.toJson();

    final Response<dynamic> response = await _httpService.putRequest(
      url: url,
      data: data,
    );

    if (response.statusCode == StatusCode.ok.code) {
      StackTrace.current.printSuccessMessage(
          message: "Parsing API response: \n${response.data}");
    } else {
      throw ServerFailure.fromResponseData(
        response: response,
        stackTrace: StackTrace.current,
      );
    }

    return UserProfileResponseDTO.fromJson(json: response.data['data']);
  }

  @override
  Future<void> changePassword({
    required ChangePasswordRequestDTO changePasswordRequestDTO,
  }) async {
    final String url = UserEndPoint.updatePassword.getUrl();

    final Map<String, dynamic> data = changePasswordRequestDTO.toJson();

    final Response<dynamic> response = await _httpService.putRequest(
      url: url,
      data: data,
    );

    if (response.statusCode == StatusCode.ok.code) {
      StackTrace.current.printSuccessMessage(
          message: "Parsing API response: \n${response.data}");
    } else {
      throw ServerFailure.fromResponseData(
        response: response,
        stackTrace: StackTrace.current,
      );
    }
  }

  @override
  Future<void> deleteAccount() async {
    final String url = UserEndPoint.removeAccount.getUrl();

    final Response<dynamic> response =
        await _httpService.deleteRequest(url: url);

    if (response.statusCode == StatusCode.ok.code) {
      StackTrace.current.printSuccessMessage(
        message: "Parsing API response: \n${response.data}",
      );
    } else {
      throw ServerFailure.fromResponseData(
        response: response,
        stackTrace: StackTrace.current,
      );
    }
  }
}
