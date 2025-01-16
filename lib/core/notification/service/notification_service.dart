import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/config/app_strings.dart';
import 'package:Flutter_CleanArchitechture/core/notification/service/notification_observable_service.dart';

class NotificationService {
  static NotificationService shared = NotificationService();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel channel;
  WidgetRef? ref;

  NotificationService() {
    _initializeNotification();
  }

  _initializeNotification() async {
    channel = const AndroidNotificationChannel(
      '@string/default_notification_channel_id', // id
      '@string/default_notification_channel_name', // title
      description:
          'This channel is use for android\'s notifications.', // description
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@drawable/ic_launcher_noti");

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse? notificationResponse) async {
        Map<String, dynamic> payload = jsonDecode(
          notificationResponse!.payload ?? AppStrings.emptyText.text,
        );
        _handleNotificationAction(payload);
      },
    );
  }

  void openAppFromBackground(RemoteMessage? message) {
    _updateNotificationBell();
    _handleNotificationAction(message?.data);
  }

  Future<void> _handleNotificationAction(Map<String, dynamic>? payload) async {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        switch (payload?['notificationTypeCode']) {
          default:
            break;
        }
      },
    );
  }

  Future<void> showLocalNotification(RemoteMessage? message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel.id, // id
      channel.name, // title
      sound: const UriAndroidNotificationSound("sound"),
      playSound: true,
      importance: Importance.high,
      priority: Priority.high,
      color: Colors.white,
    );
    var iosPlatformChannelSpecifics = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      presentBanner: true,
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);
    _updateNotificationBell();
    if (message != null) {
      RemoteNotification? notification = message.notification;
      await flutterLocalNotificationsPlugin.show(
        (message.hashCode / 100).round(),
        notification?.title,
        notification?.body,
        platformChannelSpecifics,
        payload: jsonEncode(message.data),
      );
    }
  }

  void _updateNotificationBell() {
    NotificationObservableService.isNewNotifications();
  }
}
