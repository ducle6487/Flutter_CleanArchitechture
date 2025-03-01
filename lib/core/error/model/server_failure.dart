import 'package:flutter_clean_architechture/core/error/enum/server/server_exception_type.dart';
import 'package:flutter_clean_architechture/core/error/enum/server_problem/unknown_problem_type.dart';
import 'package:flutter_clean_architechture/core/error/model/failure.dart';
import 'package:flutter_clean_architechture/core/error/model/server_failure_data.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/log/extension/log_extension.dart';
import 'package:dio/dio.dart';
import '../../internet_connection_service/internet_connection_service.dart';

class ServerFailure extends Failure {
  final ServerExceptionType serverExceptionType;
  final Enum serverProblemType;
  final int? statusCode;
  final ServerFailureData? failureData;

  ServerFailure({
    required super.stackTrace,
    required super.thrownErrorOrException,
    required this.serverExceptionType,
    required this.serverProblemType,
    required this.statusCode,
    this.failureData,
  }) {
    stackTrace.printErrorMessage(failure: this);
  }

  @override
  List<Object?> get props => [
        stackTrace,
        thrownErrorOrException,
        serverExceptionType,
        serverProblemType,
        statusCode,
        failureData,
      ];

  @override
  ServerFailure copyWith({
    StackTrace? stackTrace,
    Object? thrownErrorOrException,
    ServerExceptionType? serverExceptionType,
    Enum? serverProblemType,
    int? statusCode,
  }) {
    return ServerFailure(
      stackTrace: stackTrace ?? this.stackTrace,
      thrownErrorOrException:
          thrownErrorOrException ?? this.thrownErrorOrException,
      serverExceptionType: serverExceptionType ?? this.serverExceptionType,
      serverProblemType: serverProblemType ?? this.serverProblemType,
      statusCode: statusCode ?? this.statusCode,
      failureData: failureData,
    );
  }

  /// Creates a [ServerFailure] from [response].
  factory ServerFailure.fromResponseData({
    required StackTrace stackTrace,
    required Response<dynamic>? response,
  }) {
    final ServerFailure serverFailure;

    if (response?.data == null) {
      serverFailure = ServerFailure(
        stackTrace: stackTrace,
        thrownErrorOrException: null,
        serverExceptionType: ServerExceptionType.unknownException,
        serverProblemType: UnknownProblemType.nullResponseValueError,
        statusCode: response?.statusCode,
        failureData: null,
      );
    } else if (response?.data is! Map<String, dynamic>) {
      serverFailure = ServerFailure(
        stackTrace: stackTrace,
        thrownErrorOrException: null,
        serverExceptionType: ServerExceptionType.unknownException,
        serverProblemType: UnknownProblemType.unknownException,
        statusCode: response?.statusCode,
        failureData: null,
      );
    } else {
      serverFailure = _extractException(
        json: response?.data,
        stackTrace: stackTrace,
        statusCode: response?.statusCode,
      );
    }

    stackTrace.printErrorMessage(failure: serverFailure);
    return serverFailure;
  }

  /// Creates a [ServerFailure] from [dioException].
  factory ServerFailure.fromDioException({
    required StackTrace stackTrace,
    required DioException dioException,
  }) {
    ServerFailureData? serverFailureData;

    if (InternetConnectionService.isDisconnected()) {
      serverFailureData = ServerFailureData(
        message: LocalizationService.translateText(
          TextType.noInternet,
        ),
      );
    } else {
      if (dioException.response != null &&
          dioException.response?.data is Map<String, dynamic>) {
        serverFailureData =
            ServerFailureData.fromJson(dioException.response?.data);
      }
    }

    final ServerFailure serverFailure = ServerFailure(
      stackTrace: stackTrace,
      thrownErrorOrException: dioException,
      serverExceptionType: ServerExceptionType.dioException,
      serverProblemType: dioException.type,
      statusCode: dioException.response?.statusCode,
      failureData: serverFailureData,
    );

    stackTrace.printErrorMessage(failure: serverFailure);
    return serverFailure;
  }

  /// Creates a [ServerFailure] from [json].
  static ServerFailure _extractException({
    required Map<String, dynamic> json,
    required StackTrace stackTrace,
    required int? statusCode,
  }) {
    final ServerFailure? errorFromErrorData = _getErrorFromErrorData(
      errorData: json['error'],
      stackTrace: stackTrace,
      statusCode: statusCode,
    );

    if (errorFromErrorData != null) {
      return errorFromErrorData;
    }

    final ServerFailure? errorFromString = _createErrorDTOFromString(
      errorString: json['message'],
      stackTrace: stackTrace,
      statusCode: statusCode,
    );

    if (errorFromString != null) {
      return errorFromString;
    }

    return ServerFailure(
      stackTrace: stackTrace,
      thrownErrorOrException: null,
      serverExceptionType: ServerExceptionType.unknownException,
      serverProblemType: UnknownProblemType.unknownException,
      statusCode: statusCode,
      failureData: null,
    );
  }

  /// Creates a [ServerFailure] from [errorData].
  static ServerFailure? _getErrorFromErrorData({
    required dynamic errorData,
    required StackTrace stackTrace,
    required int? statusCode,
  }) {
    if (errorData == null) {
      return null;
    }

    if (errorData is Map<String, dynamic>) {
      final ServerExceptionType? serverExceptionType =
          ServerExceptionType.getServerExceptionByName(
              serverExceptionName: errorData['type']);
      final Enum? serverProblemType = serverExceptionType?.getProblemByName(
          serverProblemName: errorData['problem']);

      if (serverExceptionType != null && serverProblemType != null) {
        return ServerFailure(
          stackTrace: stackTrace,
          thrownErrorOrException: null,
          serverExceptionType: serverExceptionType,
          serverProblemType: serverProblemType,
          statusCode: statusCode,
          failureData: null,
        );
      }
    } else if (errorData is String) {
      return _createErrorDTOFromString(
        errorString: errorData,
        stackTrace: stackTrace,
        statusCode: statusCode,
      );
    }

    return null;
  }

  /// Creates a [ServerFailure] from [errorString].
  static ServerFailure? _createErrorDTOFromString({
    required dynamic errorString,
    required StackTrace stackTrace,
    required int? statusCode,
  }) {
    if (errorString == null ||
        errorString is! String ||
        errorString.isEmpty ||
        !errorString.contains('Type=') ||
        !errorString.contains('Problem=')) {
      return null;
    }

    final String serverSideExceptionName = errorString
        .substring(errorString.indexOf('Type=') + 5, errorString.indexOf(','))
        .trim()
        .replaceAll(' ', '_')
        .toUpperCase();
    final String serverSideProblemName = errorString
        .substring(
            errorString.indexOf('Problem=') + 8, errorString.indexOf(']'))
        .trim()
        .replaceAll(' ', '_')
        .toUpperCase();

    final ServerExceptionType? serverExceptionType =
        ServerExceptionType.getServerExceptionByName(
            serverExceptionName: serverSideExceptionName);
    final Enum? serverProblemType = serverExceptionType?.getProblemByName(
        serverProblemName: serverSideProblemName);

    if (serverExceptionType != null && serverProblemType != null) {
      return ServerFailure(
        stackTrace: stackTrace,
        thrownErrorOrException: null,
        serverExceptionType: serverExceptionType,
        serverProblemType: serverProblemType,
        statusCode: statusCode,
        failureData: null,
      );
    }

    return null;
  }
}
