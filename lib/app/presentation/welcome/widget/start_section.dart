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

class StartSection extends ConsumerWidget {
  const StartSection({
    required this.onTap,
    super.key,
  });

  final Future<void> Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget title = Text(
      LocalizationService.translateText(TextType.ariBase).toUpperCase(),
      style: const TextStyle(
        fontSize: AppFontsSize.xxxLarge,
        fontWeight: AppFontsWeight.extraBold,
        fontFamily: AppFonts.bigShoudersDisplayFont,
      ),
    );

    Widget description = Text(
      LocalizationService.translateText(TextType.welcomeStartDescription),
      style: const TextStyle(
        fontSize: AppFontsSize.medium,
      ),
    );

    Widget button = Padding(
      padding: const EdgeInsets.only(top: AppSpacings.vast),
      child: AdvancedTextButton(
        title: LocalizationService.translateText(TextType.welcomeGetStart),
        titleStyle: TextStyle(
          fontWeight: AppFontsWeight.bold,
          fontSize: AppFontsSize.normal,
          color: context.appColors.whiteTextColor,
        ),
        onTap: onTap,
        border: const AdvancedBorderModel(hasBorder: false),
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
          button,
        ],
      ),
    );
  }
}
