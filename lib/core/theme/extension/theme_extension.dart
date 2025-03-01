import 'package:flutter_clean_architechture/core/theme/model/app_colors.dart';
import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  /// A getter for [AppColors].
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
