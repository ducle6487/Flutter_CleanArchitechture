import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_radius.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdvancedBorderModel extends Equatable {
  final bool hasBorder;
  final bool isTopLeftRounded;
  final bool isTopRightRounded;
  final bool isBottomLeftRounded;
  final bool isBottomRightRounded;
  final double? radius;
  final Color? color;
  final double? width;

  const AdvancedBorderModel({
    this.hasBorder = true,
    this.radius = AppRadius.medium,
    this.isTopLeftRounded = true,
    this.isTopRightRounded = true,
    this.isBottomLeftRounded = true,
    this.isBottomRightRounded = true,
    this.color,
    this.width,
  });

  @override
  List<Object?> get props => [
        hasBorder,
        radius,
        isTopLeftRounded,
        isTopRightRounded,
        isBottomLeftRounded,
        isBottomRightRounded,
        color,
        width,
      ];

  /// Creates a copy of this class.
  AdvancedBorderModel copyWith({
    bool? hasBorder,
    double? radius,
    bool? isTopLeftRounded,
    bool? isTopRightRounded,
    bool? isBottomLeftRounded,
    bool? isBottomRightRounded,
    Color? color,
    double? width,
  }) {
    return AdvancedBorderModel(
      hasBorder: hasBorder ?? this.hasBorder,
      radius: radius ?? this.radius,
      isTopLeftRounded: isTopLeftRounded ?? this.isTopLeftRounded,
      isTopRightRounded: isTopRightRounded ?? this.isTopRightRounded,
      isBottomLeftRounded: isBottomLeftRounded ?? this.isBottomLeftRounded,
      isBottomRightRounded: isBottomRightRounded ?? this.isBottomRightRounded,
      color: color ?? this.color,
      width: width ?? this.width,
    );
  }

  /// Get [RoundedRectangleBorder].
  RoundedRectangleBorder getRoundedRectangleBorder({
    required BuildContext context,
    bool? isSelected,
    bool? isDisabled,
  }) {
    return RoundedRectangleBorder(
      borderRadius: getBorderRadius(context: context),
      side: (isDisabled != null && isDisabled)
          ? BorderSide(color: context.appColors.disableColor)
          : (hasBorder && color != null)
              ? (isSelected != null && isSelected)
                  ? BorderSide(
                      color: context.appColors.oppacityPrimaryColor,
                      width: width ?? 1.0)
                  : BorderSide(color: color!, width: width ?? 1.0)
              : BorderSide.none,
    );
  }

  /// Get [BorderRadius].
  BorderRadius getBorderRadius({required BuildContext context}) {
    return BorderRadius.only(
      topLeft: isTopLeftRounded
          ? Radius.circular(radius ?? AppDimensions.buttonBorderRadius)
          : Radius.zero,
      topRight: isTopRightRounded
          ? Radius.circular(radius ?? AppDimensions.buttonBorderRadius)
          : Radius.zero,
      bottomLeft: isBottomLeftRounded
          ? Radius.circular(radius ?? AppDimensions.buttonBorderRadius)
          : Radius.zero,
      bottomRight: isBottomRightRounded
          ? Radius.circular(radius ?? AppDimensions.buttonBorderRadius)
          : Radius.zero,
    );
  }

  BorderSide getBorderSide({
    required BuildContext context,
  }) {
    return BorderSide(
      color: color ?? context.appColors.transparentColor,
    );
  }
}
