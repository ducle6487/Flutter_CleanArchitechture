import 'package:flutter/material.dart';
import 'package:Flutter_CleanArchitechture/config/app_icons_image.dart';
import 'package:Flutter_CleanArchitechture/config/app_strings.dart';
import 'package:Flutter_CleanArchitechture/core/localization/controller/localization_controller.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/language_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';

class LocalizationService {
  static LocalizationController? _controller;

  LocalizationService._();

  static void createInstance(LocalizationController localizationController) {
    _controller = localizationController;
  }

  static String translateText(TextType textType) {
    return _controller?.translateText(textType: textType) ??
        AppStrings.emptyText.text;
  }

  static AssetImage? getLanguageFlagIcon() {
    return switch (_controller?.languageType) {
      LanguageType.english => AppIconsImage.ukFlag.asset,
      LanguageType.vietnamese => AppIconsImage.vnFlag.asset,
      _ => null,
    };
  }

  static String? getLanguageText() {
    return _controller?.languageType.shortName;
  }
}
