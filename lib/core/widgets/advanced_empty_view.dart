import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_icons_image.dart';
import 'package:Flutter_CleanArchitechture/config/app_spacings.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';

class AdvancedEmptyView extends ConsumerWidget {
  const AdvancedEmptyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacings.vast),
        child: Column(
          children: [
            const SizedBox(
              height: AppSpacings.comfortable,
            ),
            Image(
              image: AppIconsImage.empty.asset,
              height: AppDimensions.emptyIconSize,
            ),
            const SizedBox(
              height: AppSpacings.compact,
            ),
            Text(
              LocalizationService.translateText(TextType.noData),
              style: TextStyle(
                color: context.appColors.textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
