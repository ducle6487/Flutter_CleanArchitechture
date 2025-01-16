import 'package:flutter/material.dart';

enum AppIconsImage {
  homeSelected('home_selected.png'),
  home('home.png'),
  mapSelected('map_selected.png'),
  map('map.png'),
  medicalSelected('medical_selected.png'),
  medical('medical.png'),
  newsSelected('news_selected.png'),
  news('news.png'),
  notificationBell('notification.png'),
  services('services.png'),
  servicesSelected('services_selected.png'),
  heart('heart.png'),
  heartSelected('heart_selected.png'),
  defaultAvatar('default_avatar.png'),
  notification('notification_icon.png'),
  empty('empty_box.png'),
  vnFlag('vn_flag.png'),
  ukFlag('uk_flag.png'),
  defaultAppbarAvatar('default_appbar_avatar.png'),
  alert('alert.png'),
  warning('warning.png'),
  ;

  // Base path for the icons
  final String fileName;
  static const String _iconImageAsset = "assets/icons/";

  const AppIconsImage(this.fileName);

  // Method to get the AssetImage
  AssetImage get asset => AssetImage('$_iconImageAsset$fileName');
}
