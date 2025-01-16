import 'package:flutter/material.dart';
import 'package:flutter_clean_architechture/config/app_radius.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';

class StripeContainer extends StatelessWidget {
  final Widget child;

  const StripeContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    const int stripeCount = 880; // More reasonable number of stripes
    const double increment = 1.0 / (stripeCount - 1);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight, // End at bottom-right corner
          tileMode: TileMode.repeated,
          colors: List.generate(stripeCount, (index) {
            if (index % 3 != 0) {
              return context.appColors.disableColor
                  .withOpacity(0.25); // Ensure consistent color
            } else {
              return Colors.transparent;
            }
          }),
          stops: List.generate(stripeCount, (index) => index * increment),
        ),
      ),
      child: child,
    );
  }
}
