import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_font_size.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts_weight.dart';
import 'package:Flutter_CleanArchitechture/config/app_spacings.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_app_bar_icon_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final AdvancedAppBarIconModel? leading;
  final List<AdvancedAppBarIconModel>? actionList;
  final String? title;
  final bool? isTransparent;

  const AdvancedAppBar({
    super.key,
    required this.leading,
    required this.actionList,
    required this.title,
    this.isTransparent,
  });

  /// Creates a copy of this class.
  AdvancedAppBar copyWith({
    AdvancedAppBarIconModel? leading,
    List<AdvancedAppBarIconModel>? actionList,
    String? title,
    bool? isTransparent,
  }) {
    return AdvancedAppBar(
      leading: leading ?? this.leading,
      actionList: actionList ?? this.actionList,
      title: title ?? this.title,
      isTransparent: isTransparent ?? this.isTransparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      centerTitle: true,
      elevation: AppDimensions.widgetElevation,
      backgroundColor: isTransparent ?? false
          ? context.appColors.transparentColor
          : context.appColors.appBarColor,
      foregroundColor: context.appColors.textColor,
      leading: _getLeadingWidget(context: context),
      actions: _getActionsWidget(context: context),
      title: _getTitleWidget(context: context),
    );
  }

  /// Creates the title widget.
  Widget? _getTitleWidget({
    required BuildContext context,
  }) {
    if (title?.isEmpty == true) {
      return null;
    }

    return Text(
      title!.toUpperCase(),
      style: const TextStyle(
        fontWeight: AppFontsWeight.bold,
        fontSize: AppFontsSize.medium,
      ),
    );
  }

  /// Creates the leading widget.
  Widget? _getLeadingWidget({
    required BuildContext context,
  }) {
    if (leading == null) {
      return null;
    }

    return IconButton(
      icon: leading!.icon,
      tooltip: leading!.tooltip,
      onPressed: leading!.onTap,
    );
  }

  /// Creates list of [IconButton].
  List<Widget>? _getActionsWidget({
    required BuildContext context,
  }) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: AppSpacings.compact),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: (actionList ?? [])
              .map<Widget>(
                (e) => GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    if (e.onTap != null) {
                      e.onTap!();
                    }
                  },
                  child: SizedBox(
                    height: AppDimensions.tabbarIconWrapperSize,
                    width: AppDimensions.tabbarIconWrapperSize,
                    child: e.icon,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ];
  }
}
