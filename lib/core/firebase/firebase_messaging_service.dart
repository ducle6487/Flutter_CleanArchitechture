import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architechture/app/data/user/source/remote/end_point/user_end_point.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/core/api/enum/status_code.dart';
import 'package:flutter_clean_architechture/core/api/service/http_service.dart';
import 'package:flutter_clean_architechture/core/authorization/service/authorization_service.dart';
import 'package:flutter_clean_architechture/core/error/model/server_failure.dart';
import 'package:flutter_clean_architechture/core/log/extension/log_extension.dart';
import 'package:flutter_clean_architechture/core/notification/service/notification_service.dart';
import 'package:flutter_clean_architechture/core/storage/service/shared_preference_service.dart';
import 'dart:io' show Platform;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class FirebaseMessagingService {
  static FirebaseMessagingService shared = FirebaseMessagingService();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void userRequestLogout() {
    FirebaseMessaging.instance.deleteToken();
  }

  Future<void> registerFirebaseMessage() async {
    await _requestPermission();
    _storeToken();
  }

  Future<void> observeFirebaseMessaging() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      NotificationService.shared.openAppFromBackground(initialMessage);
    }
    FirebaseMessaging.onMessage.listen(
      NotificationService.shared.showLocalNotification,
    );
    FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler,
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      NotificationService.shared.openAppFromBackground,
    );
  }

  Future<void> _requestPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    await messaging.setForegroundNotificationPresentationOptions(
        alert: false, badge: true, sound: true);
  }

  void _storeToken() async {
    if (AuthorizationService.instance.isAuthorized) {
      try {
        await FirebaseMessaging.instance.getToken().then(
          (value) async {
            SharedPreferenceService.setFCMToken(
              fcmToken: value ?? AppStrings.emptyText.text,
            );

            String deviceIdentifier = '';
            DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
            if (Platform.isAndroid) {
              final AndroidDeviceInfo androidInfo =
                  await deviceInfo.androidInfo;
              deviceIdentifier = androidInfo.id;
            } else if (Platform.isIOS) {
              final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
              deviceIdentifier = iosInfo.identifierForVendor!;
            }

            Map<String, dynamic> body = {
              "token": value.toString(),
              "deviceId": deviceIdentifier,
              "deviceType": Platform.isIOS ? "ios" : "android",
            };
            registerFCM(body: body);
            StackTrace.current.printSuccessMessage(
              message: 'Register FCM body: $body',
            );
          },
        );
      } catch (e) {
        debugPrint('fail : $e');
      }
    }
  }

  Future<void> registerFCM({
    required Map<String, dynamic> body,
  }) async {
    final HttpService httpService = await HttpService.createInstance();
    final String url = UserEndPoint.registerFCM.getUrl();

    final Response<dynamic> response = await httpService.postRequest(
      url: url,
      data: body,
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

  Future<void> subscribeToTopic(String topic) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.subscribeToTopic(topic);
  }

  void unsubscribeFromTopic(String topic) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.unsubscribeFromTopic(topic);
  }
}
