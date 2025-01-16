import 'package:Flutter_CleanArchitechture/config/app_font_size.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts.dart';
import 'package:Flutter_CleanArchitechture/core/theme/model/app_colors.dart';
import 'package:flutter/material.dart';

class LightThemeConstants {
  const LightThemeConstants._();

  // Theme Data
  static const String _fontFamily = AppFonts.helveticaNeueFont;
  static const Color _colorSchemeSeed = Color(0xFF1AA553);

  // Color Palette - use https://yamada-colors.app/ define color name
  static const Color energyGreen = Color.fromARGB(102, 26, 165, 83);
  static const Color textColor = Colors.black;

  /// Theme data for the light mode.
  static final ThemeData themeData = ThemeData(
    fontFamily: _fontFamily,
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: _colorSchemeSeed,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      displayMedium: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      displaySmall: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      headlineLarge: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      headlineMedium:
          TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      headlineSmall: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      titleLarge: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      titleMedium: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      titleSmall: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      bodyLarge: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      bodyMedium: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      bodySmall: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      labelLarge: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      labelMedium: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
      labelSmall: TextStyle(color: textColor, fontSize: AppFontsSize.normal),
    ),
    extensions: [
      AppColors(
        //App Colors
        appBarColor: Colors.white,
        textColor: textColor,
        reverseTextColor: Colors.white,
        primaryColor: _colorSchemeSeed,
        secondaryColor: energyGreen,
        warningColor: Colors.amber,
        errorColor: Colors.red,
        borderColor: Colors.grey,
        backgroundColor: Colors.white,
        reverseBackgroundColor: Colors.black,

        // Custom Colors
        oppacityPrimaryColor: energyGreen,
        transparentColor: Colors.transparent,
        disableColor: Colors.grey[350]!,
        dividerColor: Colors.grey[350]!,
        shimmerBaseColor: Colors.grey[300]!,
        shimmerHighlightColor: Colors.grey[400]!,
        shadowColor: Colors.black26,
        dimBackgroundColor: Colors.grey[100]!,
        whiteTextColor: Colors.white,
        blackTextColor: Colors.black,
      )
    ],
  );
}
