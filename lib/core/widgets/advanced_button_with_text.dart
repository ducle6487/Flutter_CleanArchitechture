import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_border_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedTextButton extends ConsumerWidget {
  final String title;
  final TextStyle? titleStyle;
  final Future<void> Function()? onTap;
  final AdvancedBorderModel border;
  final bool? isTitleAtCenter;
  final Color? backgroundColor;

  const AdvancedTextButton({
    super.key,
    required this.title,
    required this.onTap,
    this.titleStyle,
    this.border = const AdvancedBorderModel(),
    this.isTitleAtCenter = true,
    this.backgroundColor,
  });

  /// Creates a copy of this class.
  AdvancedTextButton copyWith({
    String? title,
    TextStyle? titleStyle,
    Future<void> Function()? onTap,
    AdvancedBorderModel? border,
    bool? isTitleAtCenter,
    Color? backgroundColor,
  }) {
    return AdvancedTextButton(
      title: title ?? this.title,
      titleStyle: titleStyle ?? this.titleStyle,
      onTap: onTap ?? this.onTap,
      border: border ?? this.border,
      isTitleAtCenter: isTitleAtCenter ?? this.isTitleAtCenter,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppDimensions.widgetHeight,
      width: MediaQuery.sizeOf(context).width,
      child: _createTextButton(context: context),
    );
  }

  /// Creates a button.
  Widget _createTextButton({
    required BuildContext context,
  }) {
    return TextButton(
      onPressed: () {
        HapticFeedback.selectionClick();
        if (onTap != null) {
          onTap!();
        }
      },
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ?? context.appColors.primaryColor,
        ),
        shape: WidgetStatePropertyAll(
          border.getRoundedRectangleBorder(
            context: context,
            isDisabled: onTap == null,
          ),
        ),
      ),
      child: Align(
        alignment:
            isTitleAtCenter == true ? Alignment.center : Alignment.centerLeft,
        child: Text(
          title,
          style: titleStyle ?? TextStyle(color: context.appColors.textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
