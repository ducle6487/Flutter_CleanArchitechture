import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedDrawer extends ConsumerWidget {
  final Widget? child;

  const AdvancedDrawer({
    super.key,
    required this.child,
  });

  /// Creates a copy of this class.
  AdvancedDrawer copyWith({
    Widget? child,
  }) {
    return AdvancedDrawer(
      child: child ?? this.child,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: context.appColors.dimBackgroundColor,
      elevation: AppDimensions.widgetElevation,
      child: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 10.0),
        child: child ?? const SizedBox(),
      ),
    );
  }
}
