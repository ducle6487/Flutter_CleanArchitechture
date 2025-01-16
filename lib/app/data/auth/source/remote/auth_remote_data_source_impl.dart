import 'package:dio/dio.dart';
import 'package:Flutter_CleanArchitechture/app/data/auth/source/remote/auth_remote_data_source.dart';
import 'package:Flutter_CleanArchitechture/app/data/auth/source/remote/end_point/auth_end_point.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/forgot_password_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/resent_otp_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/sign_in_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/sign_in_response_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/sign_up_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/verify_request_dto.dart';
import 'package:Flutter_CleanArchitechture/core/api/enum/status_code.dart';
import 'package:Flutter_CleanArchitechture/core/api/service/http_service.dart';
import 'package:Flutter_CleanArchitechture/core/authorization/service/authorization_service.dart';
import 'package:Flutter_CleanArchitechture/core/error/enum/server/server_exception_type.dart';
import 'package:Flutter_CleanArchitechture/core/error/enum/server_problem/unknown_problem_type.dart';
import 'package:Flutter_CleanArchitechture/core/error/model/server_failure.dart';
import 'package:Flutter_CleanArchitechture/core/log/extension/log_extension.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required HttpService httpService,
  }) : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<SignInResponseDTO?> signIn({
    required SignInRequestDTO signInRequestDTO,
  }) async {
    final String url = AuthEndPoint.signIn.getUrl();

    final Map<String, dynamic> data = signInRequestDTO.toJson();

    final Response<dynamic> response = await _httpService.postRequest(
      url: url,
      data: data,
    );

    if (response.statusCode == StatusCode.ok.code) {
      StackTrace.current.printSuccessMessage(
          message: "Parsing API response: \n${response.data}");
    } else {
      throw ServerFailure.fromResponseData(
          response: response, stackTrace: StackTrace.current);
    }

    if (response.data == null) {
      throw ServerFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: null,
        serverExceptionType: ServerExceptionType.unknownException,
        serverProblemType: UnknownProblemType.nullResponseValueError,
        statusCode: response.statusCode,
      );
    }

    return SignInResponseDTO.fromJson(
      json: response.data["data"],
      statusCode: response.data["statusCode"],
    );
  }

  @override
  Future<SignInResponseDTO?> signUp({
    required SignUpRequestDTO signUpRequestDTO,
  }) async {
    final String url = AuthEndPoint.register.getUrl();

    final Map<String, dynamic> data = signUpRequestDTO.toJson();

    final Response<dynamic> response = await _httpService.postRequest(
      url: url,
      data: data,
    );

    if (response.statusCode == StatusCode.created.code) {
      StackTrace.current.printSuccessMessage(
          message: "Parsing API response: \n${response.data}");
    } else {
      throw ServerFailure.fromResponseData(
          response: response, stackTrace: StackTrace.current);
    }

    if (response.data == null) {
      throw ServerFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: null,
        serverExceptionType: ServerExceptionType.unknownException,
        serverProblemType: UnknownProblemType.nullResponseValueError,
        statusCode: response.statusCode,
      );
    }

    return SignInResponseDTO.fromJson(json: response.data['data']);
  }

  @override
  Future<void> verify({
    required VerifyRequestDTO verifyRequestDTO,
  }) async {
    final String url = AuthEndPoint.active.getUrl();

    final Map<String, dynamic> data = verifyRequestDTO.toJson();

    final Response<dynamic> response = await _httpService.postRequest(
      url: url,
      data: data,
    );

    if (response.statusCode == StatusCode.ok.code) {
      StackTrace.current.printSuccessMessage(
          message: "Parsing API response: \n${response.data}");
    } else {
      throw ServerFailure.fromResponseData(
          response: response, stackTrace: StackTrace.current);
    }

    if (response.data == null) {
      throw ServerFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: null,
        serverExceptionType: ServerExceptionType.unknownException,
        serverProblemType: UnknownProblemType.nullResponseValueError,
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<void> resendOTP({
    required ResentOTPRequestDTO resentOTPRequestDTO,
  }) async {
    final String url = AuthEndPoint.sendOtp.getUrl();

    final Map<String, dynamic> data = resentOTPRequestDTO.toJson();

    final Response<dynamic> response = await _httpService.postRequest(
      url: url,
      data: data,
    );

    if (response.statusCode == StatusCode.ok.code) {
      StackTrace.current.printSuccessMessage(
          message: "Parsing API response: \n${response.data}");
    } else {
      throw ServerFailure.fromResponseData(
          response: response, stackTrace: StackTrace.current);
    }
  }

  @override
  Future<void> forgotPassword(
      {required ForgotPasswordRequestDTO forgotPasswordRequestDTO}) async {
    final String url = AuthEndPoint.forgotPassword.getUrl();

    final Map<String, dynamic> data = forgotPasswordRequestDTO.toJson();

    final Response<dynamic> response = await _httpService.putRequest(
      url: url,
      data: data,
    );

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

  @override
  Future<void> signOut() async {
    String url = AuthEndPoint.signOut.getUrl();

    final Map<String, dynamic> data = {
      'refreshToken': AuthorizationService.instance.refreshToken,
    };

    final Response<dynamic> response = await _httpService.postRequest(
      url: url,
      data: data,
    );

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

  @override
  Future<SignInResponseDTO?> refreshToken() async {
    String url = AuthEndPoint.refreshToken.getUrl();

    final Map<String, dynamic> data = {
      'refreshToken': AuthorizationService.instance.refreshToken,
    };

    final Response<dynamic> response = await _httpService.postRequest(
      url: url,
      data: data,
    );

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

    return SignInResponseDTO.fromJson(json: response.data['data']);
  }
}
