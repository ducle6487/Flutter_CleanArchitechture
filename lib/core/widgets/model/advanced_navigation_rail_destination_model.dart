import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdvancedNavigationRailDestinationModel extends Equatable {
  final Widget unselectedIcon;
  final Widget selectedIcon;
  final String title;

  const AdvancedNavigationRailDestinationModel({
    required this.unselectedIcon,
    required this.selectedIcon,
    required this.title,
  });

  @override
  List<Object?> get props => [unselectedIcon, selectedIcon, title];

  /// Creates a copy of this class.
  AdvancedNavigationRailDestinationModel copyWith({
    Widget? unselectedIcon,
    Widget? selectedIcon,
    String? title,
  }) {
    return AdvancedNavigationRailDestinationModel(
      unselectedIcon: unselectedIcon ?? this.unselectedIcon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      title: title ?? this.title,
    );
  }
}
