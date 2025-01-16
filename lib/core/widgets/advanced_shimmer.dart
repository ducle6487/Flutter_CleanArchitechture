import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/config/app_radius.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:shimmer/shimmer.dart';

class AdvancedShimmer extends ConsumerWidget {
  final double? height;
  final double? width;
  final double? radius;
  const AdvancedShimmer({
    super.key,
    this.height,
    this.width,
    this.radius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Shimmer.fromColors(
      baseColor: context.appColors.shimmerBaseColor,
      highlightColor: context.appColors.shimmerHighlightColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: context.appColors.shimmerBaseColor,
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? AppRadius.small),
          ),
        ),
      ),
    );
  }
}
