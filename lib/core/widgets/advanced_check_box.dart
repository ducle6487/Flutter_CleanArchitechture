import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_icons.dart';
import 'package:flutter_clean_architechture/config/app_radius.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';

class AdvancedCheckBox extends ConsumerStatefulWidget {
  final bool isSelected;
  final Color? fillColor;
  final Color? borderColor;
  final double? size;
  final bool? isHighlight;
  final void Function()? onPress;

  const AdvancedCheckBox({
    super.key,
    required this.isSelected,
    required this.onPress,
    this.fillColor,
    this.borderColor,
    this.size,
    this.isHighlight,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdvancedCheckBoxState();
}

class _AdvancedCheckBoxState extends ConsumerState<AdvancedCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        if (widget.onPress != null) {
          widget.onPress!();
        }
      },
      child: Container(
        height: (widget.size ?? AppDimensions.checkBoxNomalSize) + 2,
        width: (widget.size ?? AppDimensions.checkBoxNomalSize) + 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.small),
          border: widget.isSelected
              ? null
              : Border.all(
                  width: 1,
                  color: widget.isHighlight ?? false
                      ? context.appColors.errorColor
                      : widget.borderColor ?? context.appColors.borderColor,
                ),
          color: widget.isSelected
              ? widget.fillColor ?? context.appColors.primaryColor
              : null,
        ),
        child: Icon(
          AppIcons.checked.icon,
          size: AppDimensions.checkBoxNomalSize,
          color: widget.isSelected ? Colors.white : Colors.transparent,
        ),
      ),
    );
  }
}
