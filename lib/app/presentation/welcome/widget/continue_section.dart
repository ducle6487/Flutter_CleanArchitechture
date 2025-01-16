import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/config/app_font_size.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts_weight.dart';
import 'package:Flutter_CleanArchitechture/config/app_spacings.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_button_with_text.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_border_model.dart';

class ContinueSection extends ConsumerWidget {
  const ContinueSection({
    required this.onTapYes,
    required this.onTapNo,
    super.key,
  });

  final Future<void> Function()? onTapYes;
  final Future<void> Function()? onTapNo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget title = Text(
      LocalizationService.translateText(TextType.welcomeContinueTitle),
      style: const TextStyle(
        fontFamily: AppFonts.bigShoudersDisplayFont,
        fontSize: AppFontsSize.xxLarge,
        fontWeight: AppFontsWeight.extraBold,
      ),
    );

    Widget description = Text(
      LocalizationService.translateText(TextType.welcomeContinueDescription),
      style: const TextStyle(
        fontSize: AppFontsSize.medium,
      ),
    );

    Widget yesButton = Padding(
      padding: const EdgeInsets.only(top: AppSpacings.spacious),
      child: AdvancedTextButton(
        title: LocalizationService.translateText(TextType.welcomeContinueYes),
        titleStyle: TextStyle(
          fontWeight: AppFontsWeight.bold,
          fontSize: AppFontsSize.normal,
          color: context.appColors.whiteTextColor,
        ),
        onTap: onTapYes,
        border: const AdvancedBorderModel(hasBorder: false),
      ),
    );

    Widget noButton = Padding(
      padding: const EdgeInsets.only(top: AppSpacings.cozy),
      child: AdvancedTextButton(
        title: LocalizationService.translateText(TextType.no).toUpperCase(),
        titleStyle: TextStyle(
          fontWeight: AppFontsWeight.bold,
          fontSize: AppFontsSize.normal,
          color: context.appColors.whiteTextColor,
        ),
        onTap: onTapNo,
        border: AdvancedBorderModel(
          color: context.appColors.primaryColor,
        ),
        backgroundColor: context.appColors.oppacityPrimaryColor,
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(
          left: AppSpacings.comfortable, right: AppSpacings.comfortable),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          title,
          description,
          yesButton,
          noButton,
        ],
      ),
    );
  }
}
