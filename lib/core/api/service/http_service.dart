import 'dart:io';
import 'package:flutter_clean_architechture/app/data/auth/source/remote/end_point/auth_end_point.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_in_response_dto.dart';
import 'package:flutter_clean_architechture/core/api/enum/status_code.dart';
import 'package:flutter_clean_architechture/core/authorization/service/authorization_service.dart';
import 'package:flutter_clean_architechture/core/error/enum/client/client_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/enum/server/server_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/enum/server_problem/unknown_problem_type.dart';
import 'package:flutter_clean_architechture/core/error/model/client_failure.dart';
import 'package:flutter_clean_architechture/core/error/model/failure.dart';
import 'package:flutter_clean_architechture/core/error/model/server_failure.dart';
import 'package:flutter_clean_architechture/config/app_resources.dart';
import 'package:flutter_clean_architechture/core/log/extension/log_extension.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architechture/core/storage/service/shared_preference_service.dart';

class HttpService {
  final Dio _dio;

  const HttpService({
    required Dio dio,
  }) : _dio = dio;

  /// Creates an instance of this class.
  static Future<HttpService> createInstance() async {
    final BaseOptions timeoutOptions = BaseOptions(
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    final Dio dio = Dio(timeoutOptions);

    final SecurityContext securityContext = SecurityContext.defaultContext;

    await _loadTrustCertificates(securityContext: securityContext);

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () => HttpClient(context: securityContext),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // get the language code
          String languageCode =
              SharedPreferenceService.getLanguage().languageCode;
          // Add the Accept-Language header to the request
          options.headers['Accept-Language'] = languageCode;

          // Add the access token to the request header
          options.headers['Authorization'] =
              "Bearer ${AuthorizationService.instance.accessToken}";
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == StatusCode.unAuthorized.code) {
            // If a 401 response is received, refresh the access token
            await _refreshToken(dio);

            // Update the request header with the new access token
            e.requestOptions.headers['Authorization'] =
                "Bearer ${AuthorizationService.instance.accessToken}";

            // Repeat the request with the updated header
            return handler.resolve(await dio.fetch(e.requestOptions));
          }
          return handler.next(e);
        },
      ),
    );

    return HttpService(dio: dio);
  }

  /// Load and trust the web certificates.
  static Future<void> _loadTrustCertificates({
    required SecurityContext securityContext,
  }) async {
    for (String trustCertificatePath in AppResources.trustCertificatePaths) {
      try {
        final ByteData certificateData =
            await rootBundle.load(trustCertificatePath);
        securityContext
            .setTrustedCertificatesBytes(certificateData.buffer.asUint8List());
        StackTrace.current.printSuccessMessage(
            message:
                '$trustCertificatePath certificate is trusted successfully.');
      } catch (errorOrException) {
        StackTrace.current.printErrorMessage(
          failure: ClientFailure(
            stackTrace: StackTrace.current,
            thrownErrorOrException: errorOrException,
            clientExceptionType:
                ClientExceptionType.webCertificateCouldNotBeLoaded,
          ),
        );
      }
    }
  }

  /// refresh expired token
  static Future<void> _refreshToken(Dio dio) async {
    final String url = AuthEndPoint.refreshToken.getUrl();

    dio.options.headers['Authorization'] =
        "Bearer ${AuthorizationService.instance.accessToken}";

    final Map<String, dynamic> data = {
      'refreshToken': AuthorizationService.instance.refreshToken,
    };

    try {
      final Response<dynamic> response = await dio.post(
        url,
        data: data,
      );

      if (response.statusCode == StatusCode.ok.code) {
        StackTrace.current.printSuccessMessage(
          message: "Parsing API response: \n${response.data}",
        );
        SignInResponseDTO responseData =
            SignInResponseDTO.fromJson(json: response.data['data']);
        AuthorizationService.instance.accessToken = responseData.accessToken;
        AuthorizationService.instance.refreshToken = responseData.refreshToken;
      } else {
        AuthorizationService.instance.clearToken();
        throw ServerFailure.fromResponseData(
            response: response, stackTrace: StackTrace.current);
      }

      if (response.data == null) {
        AuthorizationService.instance.clearToken();
        throw ServerFailure(
          stackTrace: StackTrace.current,
          thrownErrorOrException: null,
          serverExceptionType: ServerExceptionType.unknownException,
          serverProblemType: UnknownProblemType.nullResponseValueError,
          statusCode: response.statusCode,
        );
      }
    } catch (error) {
      AuthorizationService.instance.clearToken();
      throw Failure(
        thrownErrorOrException: error,
        stackTrace: StackTrace.current,
      );
    }
  }

  /// Performs a GET request to the specified URL.
  ///
  /// Throws a [ServerFailure] or [ClientFailure] when an error occurs.
  Future<Response<dynamic>> getRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
      );
    } on DioException catch (dioException) {
      throw ServerFailure.fromDioException(
        dioException: dioException,
        stackTrace: StackTrace.current,
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unknownException,
      );
    }
  }

  /// Performs a POST request to the specified URL.
  ///
  /// Throws a [ServerFailure] or [ClientFailure] when an error occurs.
  Future<Response<dynamic>> postRequest({
    required String url,
    dynamic data,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
        options: options,
      );
    } on DioException catch (dioException) {
      throw ServerFailure.fromDioException(
        dioException: dioException,
        stackTrace: StackTrace.current,
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unknownException,
      );
    }
  }

  /// Performs a PUT request to the specified URL.
  ///
  /// Throws a [ServerFailure] or [ClientFailure] when an error occurs.
  Future<Response<dynamic>> putRequest({
    required String url,
    dynamic data,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        url,
        data: data,
        cancelToken: cancelToken,
        options: options,
      );
    } on DioException catch (dioException) {
      throw ServerFailure.fromDioException(
        dioException: dioException,
        stackTrace: StackTrace.current,
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unknownException,
      );
    }
  }

  /// Performs a DELETE request to the specified URL.
  ///
  /// Throws a [ServerFailure] or [ClientFailure] when an error occurs.
  Future<Response<dynamic>> deleteRequest({
    required String url,
    dynamic data,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        url,
        data: data,
        cancelToken: cancelToken,
        options: options,
      );
    } on DioException catch (dioException) {
      throw ServerFailure.fromDioException(
        dioException: dioException,
        stackTrace: StackTrace.current,
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unknownException,
      );
    }
  }

  /// Performs a custom HTTP request to the specified URL.
  ///
  /// Throws a [ServerFailure] or [ClientFailure] when an error occurs.
  Future<Response<dynamic>> customRequest({
    required String url,
    dynamic data,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return await _dio.request(
        url,
        data: data,
        cancelToken: cancelToken,
        options: options,
      );
    } on DioException catch (dioException) {
      throw ServerFailure.fromDioException(
        dioException: dioException,
        stackTrace: StackTrace.current,
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.unknownException,
      );
    }
  }
}
