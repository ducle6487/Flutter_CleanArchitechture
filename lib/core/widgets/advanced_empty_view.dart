import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_icons_image.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';

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
