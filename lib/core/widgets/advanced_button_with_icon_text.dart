import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:Flutter_CleanArchitechture/config/app_icons.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_border_model.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_icon_button_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedIconTextButton extends ConsumerWidget {
  final String title;
  final TextStyle? titleStyle;
  final Future<void> Function()? onTap;
  final AdvancedIconButtonModel? leading;
  final Widget? leadingWidget;
  final AdvancedIconButtonModel? tailing;
  final Widget? tailingWidget;
  final AdvancedBorderModel border;
  final Color? backgroundColor;
  final Color? iconColor;

  const AdvancedIconTextButton({
    super.key,
    required this.title,
    this.titleStyle,
    required this.onTap,
    this.leading,
    this.leadingWidget,
    this.tailing,
    this.border = const AdvancedBorderModel(),
    this.tailingWidget,
    this.backgroundColor,
    this.iconColor,
  });

  /// Creates a copy of this class.
  AdvancedIconTextButton copyWith({
    String? title,
    TextStyle? titleStyle,
    Future<void> Function()? onTap,
    AdvancedIconButtonModel? leading,
    Widget? leadingWidget,
    AdvancedIconButtonModel? tailing,
    AdvancedBorderModel? border,
    Widget? tailingWidget,
    Color? backgroundColor,
    Color? iconColor,
  }) {
    return AdvancedIconTextButton(
      title: title ?? this.title,
      titleStyle: titleStyle ?? this.titleStyle,
      onTap: onTap ?? this.onTap,
      leading: leading ?? this.leading,
      leadingWidget: leadingWidget ?? this.leadingWidget,
      tailing: tailing ?? this.tailing,
      border: border ?? this.border,
      tailingWidget: tailingWidget ?? this.tailingWidget,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _createIconTextButton(context: context);
  }

  /// Creates a button.
  Widget _createIconTextButton({required BuildContext context}) {
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
        side: WidgetStatePropertyAll(
          border.getBorderSide(
            context: context,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize:
            tailingWidget == null ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                leadingWidget ??
                    _createIconButton(
                        iconButtonModel: leading, context: context),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      title,
                      maxLines: 1,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (tailing != null || tailingWidget != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: tailingWidget ??
                  _createIconButton(iconButtonModel: tailing, context: context),
            ),
        ],
      ),
    );
  }

  /// Creates the leading and tailing icon buttons.
  Widget _createIconButton({
    required AdvancedIconButtonModel? iconButtonModel,
    required BuildContext context,
  }) {
    if (iconButtonModel == null) {
      return Icon(
        AppIcons.unknown.icon,
        color: context.appColors.transparentColor,
      );
    }
    return GestureDetector(
      onTap: iconButtonModel.onTap,
      child: Tooltip(
        message: iconButtonModel.tooltip,
        child: Icon(
          iconButtonModel.icon,
          size: iconButtonModel.size,
          color:
              iconButtonModel.color ?? iconColor ?? context.appColors.textColor,
        ),
      ),
    );
  }
}
