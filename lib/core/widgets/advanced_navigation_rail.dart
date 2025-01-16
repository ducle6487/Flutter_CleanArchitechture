import 'package:flutter_clean_architechture/config/app_fonts_weight.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_navigation_rail_destination_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedNavigationRail extends ConsumerWidget {
  final List<AdvancedNavigationRailDestinationModel> destinations;
  final int currentIndex;
  final Future<void> Function(int index) onTap;

  const AdvancedNavigationRail({
    super.key,
    required this.destinations,
    required this.currentIndex,
    required this.onTap,
  });

  /// Creates a copy of this class.
  AdvancedNavigationRail copyWith({
    List<AdvancedNavigationRailDestinationModel>? destinations,
    int? currentIndex,
    Future<void> Function(int index)? onTap,
  }) {
    return AdvancedNavigationRail(
      destinations: destinations ?? this.destinations,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationRailTheme(
      data: NavigationRailThemeData(
        indicatorColor: context.appColors.backgroundColor,
        backgroundColor: context.appColors.backgroundColor,
        labelType: NavigationRailLabelType.all,
        selectedIconTheme: IconThemeData(
          color: context.appColors.textColor,
        ),
        selectedLabelTextStyle: TextStyle(
          color: context.appColors.textColor,
          fontWeight: AppFontsWeight.semiBold,
        ),
        unselectedIconTheme: IconThemeData(
          color: context.appColors.disableColor,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: context.appColors.disableColor,
        ),
      ),
      child: NavigationRail(
        indicatorColor: context.appColors.backgroundColor,
        backgroundColor: context.appColors.backgroundColor,
        destinations: _createDestinationItemList(context: context),
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
      ),
    );
  }

  /// Creates list of [NavigationRailDestination].
  List<NavigationRailDestination> _createDestinationItemList({
    required BuildContext context,
  }) {
    return destinations
        .map<NavigationRailDestination>(
          (e) => NavigationRailDestination(
            icon: e.unselectedIcon,
            selectedIcon: e.selectedIcon,
            label: Text(e.title.toUpperCase()),
          ),
        )
        .toList();
  }
}
