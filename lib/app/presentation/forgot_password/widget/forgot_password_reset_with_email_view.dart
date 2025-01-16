import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/forgot_password_request_dto.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_font_size.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts_weight.dart';
import 'package:Flutter_CleanArchitechture/config/app_spacings.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:Flutter_CleanArchitechture/core/router/enum/router_type.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import '../../../../config/app_regex.dart';
import '../../../../core/widgets/advanced_button_with_text.dart';
import '../../../../core/widgets/advanced_textfield_form.dart';
import '../../../../core/dialog/dialog_service.dart';
import '../../../../core/widgets/model/advanced_border_model.dart';
import '../../sign_in/enum/sign_in_validate_type.dart';
import '../controller/forgot_password_view_controller.dart';
import '../provider/forgot_password_view_provider.dart';

class ForgotPasswordResetWithEmailView extends ConsumerWidget {
  const ForgotPasswordResetWithEmailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ForgotPasswordViewState state = ref
        .watch(ForgotPasswordViewProvider.forgotPasswordViewControllerProvider);

    Widget title = Padding(
      padding: const EdgeInsets.only(
        left: AppSpacings.comfortable,
      ),
      child: Text(
        LocalizationService.translateText(TextType.resetPassWithEmailTitle),
        style: const TextStyle(
          fontFamily: AppFonts.bigShoudersDisplayFont,
          fontSize: AppFontsSize.xxLarge,
          fontWeight: AppFontsWeight.bold,
        ),
      ),
    );

    Widget content = Padding(
      padding: const EdgeInsets.only(left: AppSpacings.comfortable),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            LocalizationService.translateText(
              TextType.resetPassWithEmailContent,
            ),
            style: const TextStyle(
              fontFamily: AppFonts.helveticaNeueFont,
              fontSize: AppFontsSize.normal,
              fontWeight: AppFontsWeight.regular,
            ),
          ),
        ],
      ),
    );

    Widget titleWrapper = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        title,
        content,
      ],
    );

    Widget emailInput = Padding(
      padding: const EdgeInsets.all(AppSpacings.comfortable),
      child: AdvancedTextFieldForm(
        textEditingController:
            state.emailTFController, // Controller for text input
        focusNode: FocusNode(), // Focus node for controlling focus
        hintText:
            LocalizationService.translateText(TextType.email), // Hint text
        maxLines: 1, // Maximum lines allowed in the text field
        keyboardType: TextInputType.emailAddress,
      ),
    );

    Widget okButton = Padding(
      padding: const EdgeInsets.only(
          left: AppSpacings.comfortable,
          top: AppSpacings.vast,
          right: AppSpacings.comfortable),
      child: AdvancedTextButton(
        title: LocalizationService.translateText(TextType.ok).toUpperCase(),
        titleStyle: const TextStyle(
          fontWeight: AppFontsWeight.bold,
          fontSize: AppFontsSize.normal,
        ),
        onTap: () async {
          await _onTapOk(ref, context);
        },
        border: const AdvancedBorderModel(hasBorder: false),
      ),
    );

    Widget notRememberEmailButton = Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacings.cozy),
        child: GestureDetector(
          onTap: () => _goToForgotPasswordScreen(context),
          child: Text(
            LocalizationService.translateText(TextType.notRememberEmail),
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: context.appColors.backgroundColor,
              decorationThickness: AppDimensions.decorationThickness,
            ),
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleWrapper,
        emailInput,
        okButton,
        notRememberEmailButton,
      ],
    );
  }

  void _goToForgotPasswordScreen(BuildContext context) {
    context.goNamed(RouterType.forgotPassword.name);
  }
}

extension ForgotPasswordResetWithEmailViewFunc
    on ForgotPasswordResetWithEmailView {
  Future<void> _onTapOk(WidgetRef ref, BuildContext context) async {
    ForgotPasswordViewState state = ref
        .watch(ForgotPasswordViewProvider.forgotPasswordViewControllerProvider);

    if (_isValidEmail(state)) {
      final forgotPasswordController = ref.read(ForgotPasswordViewProvider
          .forgotPasswordViewControllerProvider.notifier);
      forgotPasswordController.resetPassword(
        forgotPasswordRequestDTO:
            ForgotPasswordRequestDTO(state.emailTFController.text, true),
      );
    } else {
      DialogService().authInValidDialog(AuthValidateType.invalidEmail);
    }
  }

  bool _isValidEmail(ForgotPasswordViewState state) {
    return AppRegex.email.regExp.hasMatch(state.emailTFController.text);
  }
}
