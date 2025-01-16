import 'package:dio/dio.dart';
import 'package:flutter_clean_architechture/app/data/notification/source/remote/end_point/notification_end_point.dart';
import 'package:flutter_clean_architechture/app/data/notification/source/remote/notification_remote_data_source.dart';
import 'package:flutter_clean_architechture/app/domain/notification/model/notification_response_dto.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/core/api/model/pagination_wrapper_dto.dart';
import 'package:flutter_clean_architechture/core/api/enum/status_code.dart';
import 'package:flutter_clean_architechture/core/api/service/http_service.dart';
import 'package:flutter_clean_architechture/core/error/model/server_failure.dart';
import 'package:flutter_clean_architechture/core/log/extension/log_extension.dart';

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  const NotificationRemoteDataSourceImpl({
    required HttpService httpService,
  }) : _httpService = httpService;

  final HttpService _httpService;

  @override
  Future<PaginationWrapperDTO?> getNotificationHistory() async {
    String url = NotificationEndPoint.getNotificationHistory.getUrl();

    final Response<dynamic> response = await _httpService.getRequest(
      url: url,
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

    final List<NotificationResponseDTO> list = [];
    for (var noti in response.data['data']) {
      list.add(NotificationResponseDTO.fromJson(json: noti));
    }

    return PaginationWrapperDTO.withData(
      data: list,
      json: response.data,
    );
  }

  @override
  Future<PaginationWrapperDTO?> loadMoreNotificationHistory({
    required int? page,
  }) async {
    String url = NotificationEndPoint.getNotificationHistory.getUrl();

    Map<String, dynamic> queryParameters = {
      AppStrings.page.text: page,
    };

    final Response<dynamic> response = await _httpService.getRequest(
      url: url,
      queryParameters: queryParameters,
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

    final List<NotificationResponseDTO> list = [];
    for (var noti in response.data['data']) {
      list.add(NotificationResponseDTO.fromJson(json: noti));
    }

    return PaginationWrapperDTO.withData(
      data: list,
      json: response.data,
    );
  }

  @override
  Future<void> markAsReadNotification({
    required String notificationId,
  }) async {
    String url = NotificationEndPoint.markAsReadNotification.getUrl() +
        notificationId.toString();

    final Response<dynamic> response = await _httpService.putRequest(
      url: url,
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
  Future<int> getUnReadNotificationsCount() async {
    String url = NotificationEndPoint.getUnReadNotificationsCount.getUrl();

    final Response<dynamic> response = await _httpService.getRequest(url: url);

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

    return response.data['data']['total'];
  }

  @override
  Future<void> clearNewNotification() async {
    String url = NotificationEndPoint.clearNewNotification.getUrl();

    final Response<dynamic> response = await _httpService.putRequest(url: url);

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
