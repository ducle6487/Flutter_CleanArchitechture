import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_font_size.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts_weight.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_bottom_navigation_bar_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedNavigationBar extends ConsumerWidget {
  final List<AdvancedNavigationBarItemModel> items;
  final int currentIndex;
  final Future<void> Function(int index) onTap;

  const AdvancedNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  /// Creates a copy of this class.
  AdvancedNavigationBar copyWith({
    List<AdvancedNavigationBarItemModel>? items,
    int? currentIndex,
    Future<void> Function(int index)? onTap,
  }) {
    return AdvancedNavigationBar(
      items: items ?? this.items,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (Set<WidgetState> states) => states.contains(WidgetState.selected)
              ? TextStyle(
                  color: context.appColors.primaryColor,
                  fontSize: AppFontsSize.xxxSmall,
                  fontWeight: AppFontsWeight.semiBold,
                )
              : TextStyle(
                  color: context.appColors.textColor,
                  fontSize: AppFontsSize.xxxSmall,
                ),
        ),
        elevation: AppDimensions.widgetElevation,
        indicatorColor: context.appColors.backgroundColor,
        backgroundColor: context.appColors.backgroundColor,
        surfaceTintColor: context.appColors.backgroundColor,
        shadowColor: context.appColors.backgroundColor,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            return context
                .appColors.backgroundColor; // Use the component's default.
          },
        ),
      ),
      child: NavigationBar(
        indicatorColor: context.appColors.backgroundColor,
        backgroundColor: context.appColors.backgroundColor,
        surfaceTintColor: context.appColors.backgroundColor,
        shadowColor: context.appColors.backgroundColor,
        elevation: AppDimensions.widgetElevation,
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        height: AppDimensions.bottomAppBarHeight,
        destinations: _createItemList(context: context),
      ),
    );
  }

  /// Creates list of [BottomNavigationBarItem].
  List<NavigationDestination> _createItemList({required BuildContext context}) {
    return items
        .map<NavigationDestination>(
          (e) => NavigationDestination(
            icon: e.unselectedIcon,
            selectedIcon: e.selectedIcon,
            label: e.title,
            tooltip: e.tooltip,
          ),
        )
        .toList();
  }
}
