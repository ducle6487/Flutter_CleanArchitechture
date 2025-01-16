import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/sign_in/widget/sign_in_form_view.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_font_size.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts_weight.dart';
import 'package:Flutter_CleanArchitechture/config/app_spacings.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:Flutter_CleanArchitechture/core/router/enum/router_type.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';

class SignInContentView extends ConsumerWidget {
  const SignInContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget title = Padding(
      padding: const EdgeInsets.only(left: AppSpacings.comfortable),
      child: Text(
        LocalizationService.translateText(TextType.signin),
        style: const TextStyle(
          fontFamily: AppFonts.bigShoudersDisplayFont,
          fontSize: AppFontsSize.xxLarge,
          fontWeight: AppFontsWeight.bold,
        ),
      ),
    );

    Widget forgotPasswordButton = Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacings.cozy),
        child: GestureDetector(
          onTap: () => _goToForgotPasswordScreen(context),
          child: Text(
            LocalizationService.translateText(TextType.forgotPassword),
            style: TextStyle(
              decoration:
                  TextDecoration.underline, // Optional: Set underline color
              decorationThickness: AppDimensions.decorationThickness,
            ),
          ),
        ),
      ),
    );

    Widget signUpButton = Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacings.spacious),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              LocalizationService.translateText(TextType.haveNotGotAccount),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppSpacings.squishy),
              child: InkWell(
                onTap: () => _goToSignUpScreen(context),
                child: Text(
                  LocalizationService.translateText(TextType.signUp)
                      .toUpperCase(),
                  style: TextStyle(
                    fontWeight: AppFontsWeight.bold,
                    color: context.appColors.primaryColor,
                  ),
                ), // Make highlight color transparent
              ),
            ),
          ],
        ),
      ),
    );

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: Get.height / AppDimensions.signInFormHeightRatio,
            child: Wrap(
              children: [
                title,
                const SignInFormView(),
                forgotPasswordButton,
              ],
            ),
          ),
          signUpButton
        ],
      ),
    );

    //                 signUpButton
  }

  void _goToSignUpScreen(BuildContext context) {
    context.goNamed(RouterType.signUp.name);
  }

  void _goToForgotPasswordScreen(BuildContext context) {
    context.goNamed(RouterType.forgotPassword.name);
  }
}
