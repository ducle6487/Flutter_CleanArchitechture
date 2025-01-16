import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdvancedIconButtonModel extends Equatable {
  final IconData? icon;
  final String? svgIcon;
  final double size;
  final String tooltip;
  final Future<void> Function()? onTap;
  final Color? color;

  const AdvancedIconButtonModel({
    this.icon,
    this.svgIcon,
    required this.tooltip,
    required this.onTap,
    this.size = 24.0,
    this.color,
  });

  @override
  List<Object?> get props => [icon, svgIcon, size, tooltip, onTap, color];

  /// Creates a copy of this class.
  AdvancedIconButtonModel copyWith({
    IconData? icon,
    String? svgIcon,
    String? tooltip,
    double? size,
    Future<void> Function()? onTap,
    Color? color,
  }) {
    return AdvancedIconButtonModel(
      icon: icon ?? this.icon,
      svgIcon: svgIcon ?? this.svgIcon,
      tooltip: tooltip ?? this.tooltip,
      onTap: onTap ?? this.onTap,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }
}
