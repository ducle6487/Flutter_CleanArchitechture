import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedHorizontalDivider extends ConsumerWidget {
  final EdgeInsetsGeometry? padding;
  final Color? color;
  const AdvancedHorizontalDivider({
    super.key,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding:
          padding != null ? padding! : const EdgeInsets.all(AppDimensions.zero),
      child: Divider(
        height: 1,
        color: color ?? context.appColors.dividerColor,
      ),
    );
  }
}
