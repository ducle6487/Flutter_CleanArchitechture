import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_up/widget/sign_up_form_view.dart';
import 'package:flutter_clean_architechture/config/app_font_size.dart';
import 'package:flutter_clean_architechture/config/app_fonts.dart';
import 'package:flutter_clean_architechture/config/app_fonts_weight.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_button_with_text.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_divider_horizontal.dart';

class SignUpContentView extends ConsumerWidget {
  const SignUpContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget title = Text(
      LocalizationService.translateText(TextType.signUp),
      style: const TextStyle(
        fontFamily: AppFonts.bigShoudersDisplayFont,
        fontSize: AppFontsSize.xxLarge,
        fontWeight: AppFontsWeight.bold,
      ),
    );

    Widget divider = const Padding(
      padding: EdgeInsets.only(top: AppSpacings.comfortable),
      child: AdvancedHorizontalDivider(),
    );

    Widget joinAsGuest = Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacings.compact),
          child: Text(
            LocalizationService.translateText(TextType.or),
            style: TextStyle(color: context.appColors.textColor),
          ),
        ),
        AdvancedTextButton(
          title: LocalizationService.translateText(TextType.joinAsGuest)
              .toUpperCase(),
          backgroundColor: context.appColors.oppacityPrimaryColor,
          titleStyle: TextStyle(
            fontWeight: AppFontsWeight.bold,
            fontSize: AppFontsSize.normal,
            color: context.appColors.whiteTextColor,
          ),
          onTap: () async {},
        ),
      ],
    );

    Widget joinAsGuestDesc = Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacings.compact),
      alignment: Alignment.center,
      child: Text(
        LocalizationService.translateText(TextType.joinAsGuestExplain),
        style: const TextStyle(fontSize: AppFontsSize.xxSmall),
      ),
    );

    Widget signInSection = Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        top: AppSpacings.tight,
        bottom: AppSpacings.comfortable,
      ),
      child: Column(
        children: [
          Text(
            LocalizationService.translateText(TextType.alreadyHaveAccount),
          ),
          InkWell(
            onTap: () => _goToSignInView(context),
            child: Text(
              LocalizationService.translateText(TextType.signin).toUpperCase(),
              style: TextStyle(
                  fontWeight: AppFontsWeight.bold,
                  color: context.appColors.primaryColor),
            ), // Make highlight color transparent
          )
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacings.comfortable),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              const SignUpFormView(),
              divider,
              joinAsGuest,
              joinAsGuestDesc,
              signInSection,
            ],
          ),
        ],
      ),
    );
  }

  void _goToSignInView(BuildContext context) {
    context.pop();
  }
}
