import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_font_size.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts_weight.dart';
import 'package:Flutter_CleanArchitechture/config/app_radius.dart';
import 'package:Flutter_CleanArchitechture/config/app_spacings.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_shimmer.dart';

class AdvancedListTile extends ConsumerWidget {
  final bool? isLoading;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Color? leadingIconColor;
  final Color? trailingIconColor;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final String? title;
  final Color? titleColor;
  final String? subtitle;
  final Future<void> Function()? onTap;
  final Future<void> Function()? onLongPress;
  final bool? isFirst;
  final bool? isLast;

  const AdvancedListTile({
    super.key,
    this.isLoading,
    this.leadingIcon,
    this.trailingIcon,
    this.leadingIconColor,
    this.trailingIconColor,
    required this.title,
    this.titleColor,
    this.subtitle,
    required this.onTap,
    this.onLongPress,
    this.trailingWidget,
    this.leadingWidget,
    this.isFirst,
    this.isLast,
  });

  /// Creates a copy of this class.
  AdvancedListTile copyWith({
    bool? isLoading,
    IconData? leadingIcon,
    IconData? trailingIcon,
    Color? leadingIconColor,
    Color? trailingIconColor,
    String? title,
    String? subtitle,
    Future<void> Function()? onTap,
    Future<void> Function()? onLongPress,
    Widget? trailingWidget,
    Widget? leadingWidget,
    bool? isFirst,
    bool? isLast,
  }) {
    return AdvancedListTile(
      isLoading: isLoading ?? this.isLoading,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      leadingIconColor: leadingIconColor ?? this.leadingIconColor,
      trailingIconColor: trailingIconColor ?? this.trailingIconColor,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      onTap: onTap ?? this.onTap,
      onLongPress: onLongPress ?? this.onLongPress,
      trailingWidget: trailingWidget ?? this.trailingWidget,
      leadingWidget: leadingWidget ?? this.leadingWidget,
      isFirst: isFirst ?? this.isFirst,
      isLast: isLast ?? this.isLast,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget listTile = GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        if (onTap != null) {
          onTap!();
        }
      },
      onLongPress: () {
        HapticFeedback.selectionClick();
        if (onLongPress != null) {
          onLongPress!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.backgroundColor,
          borderRadius: isFirst != null && isFirst! && isLast != null && isLast!
              ? BorderRadius.circular(AppRadius.medium)
              : isFirst != null && isFirst!
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(AppRadius.medium),
                      topRight: Radius.circular(AppRadius.medium),
                    )
                  : isLast != null && isLast!
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(AppRadius.medium),
                          bottomRight: Radius.circular(AppRadius.medium),
                        )
                      : null,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacings.comfortable,
            bottom: AppSpacings.comfortable,
            top: AppSpacings.comfortable,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    if (leadingIcon != null)
                      Row(
                        children: [
                          _getLeadingWidget(context: context),
                          const SizedBox(
                            width: AppSpacings.cozy,
                          ),
                        ],
                      ),
                    if (leadingWidget != null)
                      Row(
                        children: [
                          leadingWidget!,
                          const SizedBox(
                            width: AppSpacings.cozy,
                          ),
                        ],
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null && title?.isEmpty != true)
                            _getTitleWidget(context: context),
                          if (subtitle != null && subtitle?.isEmpty != true)
                            _getSubtitleWidget(context: context),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: AppSpacings.cozy,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (trailingWidget != null) trailingWidget!,
                  if (trailingIcon != null)
                    _getTrailingWidget(context: context),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    Widget shimmer = AdvancedShimmer(
      height: AppDimensions.shimmerLineHeightMedium,
      radius: AppRadius.large,
    );

    return (isLoading != null && isLoading!) ? shimmer : listTile;
  }

  /// Creates the title widget.
  Widget _getTitleWidget({required BuildContext context}) {
    return Text(
      title!,
      style: TextStyle(
        fontWeight: AppFontsWeight.semiBold,
        fontSize: AppFontsSize.smallMedium,
        color: titleColor ?? context.appColors.textColor,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 3, // Adjust as needed
    );
  }

  /// Creates the subtitle widget.
  Widget _getSubtitleWidget({required BuildContext context}) {
    return Text(
      subtitle!,
      style: TextStyle(
        fontSize: AppFontsSize.small,
        color: context.appColors.textColor,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2, // Adjust as needed
    );
  }

  /// Creates the leading widget.
  Widget _getLeadingWidget({required BuildContext context}) {
    return Icon(
      leadingIcon,
      color: leadingIconColor ?? context.appColors.textColor,
      size: AppDimensions.listTileLeadingIconSize,
    );
  }

  /// Creates the trailing widget.
  Widget _getTrailingWidget({required BuildContext context}) {
    return Icon(
      trailingIcon,
      color: trailingIconColor ?? context.appColors.textColor,
      size: AppDimensions.listTileTrailingIconSize,
    );
  }
}
