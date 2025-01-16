import 'package:flutter/material.dart';

enum AppImages {
  splashTopPart('splash_top_part.png'),
  splashCenterPart('splash_center_part.png'),
  splashBottomPart('splash_bottom_part.png'),
  welcomeBackground('welcome_background.png'),
  welcomeMask('welcome_mask.png'),
  signInBottomPart('sign_in_bottom_part.png'),
  signInTopPart('sign_in_top_part.png'),
  imageNotificationDetail('notification_detail_image.png'),
  backgroundBottomSheet('background_bottom_sheet.png'),
  backgroundHealthRiskDetail('health_risk_detail_back_ground.jpg'),
  noImage('no_image.jpg'),
  centerPatternBackground('center_pattern_background.png'),
  popupBackground('popup_background.png'),
  ;

  // Base path for the images
  final String fileName;
  static const String _assetImage = "assets/images/";

  const AppImages(this.fileName);

  // Method to get the AssetImage
  AssetImage get asset => AssetImage('$_assetImage$fileName');
}
