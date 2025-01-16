import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_border_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedIconButton extends ConsumerWidget {
  final Widget icon;
  final String tooltip;
  final Future<void> Function()? onTap;
  final AdvancedBorderModel border;
  final Color? backgroundColor;

  const AdvancedIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.border = const AdvancedBorderModel(),
    this.backgroundColor,
  });

  /// Creates a copy of this class.
  AdvancedIconButton copyWith({
    Widget? icon,
    String? tooltip,
    Future<void> Function()? onTap,
    AdvancedBorderModel? border,
    Color? backgroundColor,
  }) {
    return AdvancedIconButton(
      icon: icon ?? this.icon,
      tooltip: tooltip ?? this.tooltip,
      onTap: onTap ?? this.onTap,
      border: border ?? this.border,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppDimensions.widgetHeight,
      width: MediaQuery.sizeOf(context).width,
      child: Tooltip(
        message: tooltip,
        child: _createIconButton(context: context),
      ),
    );
  }

  /// Creates a button.
  Widget _createIconButton({required BuildContext context}) {
    return IconButton(
      onPressed: () {
        HapticFeedback.selectionClick();
        if (onTap != null) {
          onTap!();
        }
      },
      icon: icon,
      tooltip: tooltip,
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
    );
  }
}
