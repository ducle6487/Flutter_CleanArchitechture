import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  //App Colors
  final Color appBarColor;
  final Color textColor;
  final Color reverseTextColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color warningColor;
  final Color errorColor;
  final Color borderColor;
  final Color backgroundColor;
  final Color reverseBackgroundColor;

  // Custom Colors - define name can use various situations
  final Color oppacityPrimaryColor;
  final Color transparentColor;
  final Color disableColor;
  final Color dividerColor;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;
  final Color shadowColor;
  final Color dimBackgroundColor;
  final Color whiteTextColor;
  final Color blackTextColor;

  const AppColors({
    //App Colors
    required this.appBarColor,
    required this.textColor,
    required this.reverseTextColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.warningColor,
    required this.errorColor,
    required this.borderColor,
    required this.backgroundColor,
    required this.reverseBackgroundColor,

    // Custom Colors
    required this.oppacityPrimaryColor,
    required this.transparentColor,
    required this.disableColor,
    required this.dividerColor,
    required this.shimmerBaseColor,
    required this.shimmerHighlightColor,
    required this.shadowColor,
    required this.dimBackgroundColor,
    required this.whiteTextColor,
    required this.blackTextColor,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    //App Colors
    final Color? appBarColor,
    final Color? textColor,
    final Color? reverseTextColor,
    final Color? primaryColor,
    final Color? secondaryColor,
    final Color? warningColor,
    final Color? errorColor,
    final Color? borderColor,
    final Color? backgroundColor,
    final Color? reverseBackgroundColor,

    // Custom Colors - define name can use various situations
    final Color? oppacityPrimaryColor,
    final Color? transparentColor,
    final Color? disableColor,
    final Color? dividerColor,
    final Color? shimmerBaseColor,
    final Color? shimmerHighlightColor,
    final Color? shadowColor,
    final Color? dimBackgroundColor,
    final Color? whiteTextColor,
    final Color? blackTextColor,
  }) {
    return AppColors(
      //App Colors
      appBarColor: appBarColor ?? this.appBarColor,
      textColor: textColor ?? this.textColor,
      reverseTextColor: reverseTextColor ?? this.reverseTextColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      borderColor: borderColor ?? this.borderColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      reverseBackgroundColor:
          reverseBackgroundColor ?? this.reverseBackgroundColor,

      // Custom Colors
      oppacityPrimaryColor: oppacityPrimaryColor ?? this.oppacityPrimaryColor,
      transparentColor: transparentColor ?? this.transparentColor,
      disableColor: disableColor ?? this.disableColor,
      dividerColor: dividerColor ?? this.dividerColor,
      shimmerBaseColor: shimmerBaseColor ?? this.shimmerBaseColor,
      shimmerHighlightColor:
          shimmerHighlightColor ?? this.shimmerHighlightColor,
      shadowColor: shadowColor ?? this.shadowColor,
      dimBackgroundColor: dimBackgroundColor ?? this.dimBackgroundColor,
      whiteTextColor: whiteTextColor ?? this.whiteTextColor,
      blackTextColor: blackTextColor ?? this.blackTextColor,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other == null || other is! AppColors) {
      return this;
    }

    return AppColors(
      // App Colors
      appBarColor: Color.lerp(appBarColor, other.appBarColor, t) ?? appBarColor,
      textColor: Color.lerp(textColor, other.textColor, t) ?? textColor,
      reverseTextColor:
          Color.lerp(reverseTextColor, other.reverseTextColor, t) ??
              reverseTextColor,
      primaryColor:
          Color.lerp(primaryColor, other.primaryColor, t) ?? primaryColor,
      secondaryColor:
          Color.lerp(secondaryColor, other.secondaryColor, t) ?? secondaryColor,
      warningColor:
          Color.lerp(warningColor, other.warningColor, t) ?? warningColor,
      errorColor: Color.lerp(errorColor, other.errorColor, t) ?? errorColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      reverseBackgroundColor:
          Color.lerp(reverseBackgroundColor, other.reverseBackgroundColor, t) ??
              reverseBackgroundColor,

      // Custom Colors
      oppacityPrimaryColor:
          Color.lerp(oppacityPrimaryColor, other.oppacityPrimaryColor, t) ??
              oppacityPrimaryColor,
      transparentColor:
          Color.lerp(transparentColor, other.transparentColor, t) ??
              transparentColor,
      disableColor:
          Color.lerp(disableColor, other.disableColor, t) ?? disableColor,
      dividerColor:
          Color.lerp(dividerColor, other.dividerColor, t) ?? dividerColor,
      shimmerBaseColor:
          Color.lerp(shimmerBaseColor, other.shimmerBaseColor, t) ??
              shimmerBaseColor,
      shimmerHighlightColor:
          Color.lerp(shimmerHighlightColor, other.shimmerHighlightColor, t) ??
              shimmerHighlightColor,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      dimBackgroundColor:
          Color.lerp(dimBackgroundColor, other.dimBackgroundColor, t) ??
              dimBackgroundColor,
      whiteTextColor:
          Color.lerp(whiteTextColor, other.whiteTextColor, t) ?? whiteTextColor,
      blackTextColor:
          Color.lerp(blackTextColor, other.blackTextColor, t) ?? blackTextColor,
    );
  }
}
