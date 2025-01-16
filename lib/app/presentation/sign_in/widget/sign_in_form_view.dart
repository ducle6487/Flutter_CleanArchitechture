import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/model/sign_in_request_dto.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/sign_in/controller/sign_in_view_controller.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/sign_in/provider/sign_in_view_provider.dart';
import 'package:Flutter_CleanArchitechture/config/app_font_size.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts_weight.dart';
import 'package:Flutter_CleanArchitechture/config/app_regex.dart';
import 'package:Flutter_CleanArchitechture/config/app_spacings.dart';
import 'package:Flutter_CleanArchitechture/config/app_svg_icons.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_button_with_text.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_textfield_form.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_icon_button_model.dart';
import '../../../../core/localization/service/localization_service.dart';

class SignInFormView extends ConsumerWidget {
  const SignInFormView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SignInViewState state =
        ref.watch(SignInViewProvider.signInViewControllerProvider);
    SignInViewController controller =
        ref.watch(SignInViewProvider.signInViewControllerProvider.notifier);

    Widget emailInput = Padding(
      padding: const EdgeInsets.all(AppSpacings.comfortable),
      child: AdvancedTextFieldForm(
        textEditingController:
            state.emailTFController, // Controller for text input
        focusNode: state.emailFocusNode, // Focus node for controlling focus
        hintText:
            LocalizationService.translateText(TextType.email), // Hint text
        maxLines: 1, // Maximum lines allowed in the text field
        validator: state.emailErrorText,
        onFieldSubmitted: (value) async {
          controller.validateSignInForm(
            emailErrorText: _isValidEmail(state),
            passwordErrorText: state.passwordErrorText,
          );
        },
      ),
    );

    Widget passwordInput = Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacings.comfortable),
      child: AdvancedTextFieldForm(
        obscureText: state.isObscureTextField,
        textEditingController:
            state.passwordTFController, // Controller for text input
        focusNode: state.passwordFocusNode, // Focus node for controlling focus
        hintText:
            LocalizationService.translateText(TextType.password), // Hint text
        maxLines: 1, // Maximum lines allowed in the text field
        validator: state.passwordErrorText,
        onFieldSubmitted: (value) async {
          controller.validateSignInForm(
            emailErrorText: state.emailErrorText,
            passwordErrorText: _isValidPassword(state),
          );
        },
        suffixIconButton: AdvancedIconButtonModel(
          color: context.appColors.textColor,
          svgIcon: state.isObscureTextField
              ? AppSvgIcons.eyeShow.svg
              : AppSvgIcons.eyeHide.svg,
          tooltip: controller.isObscureTextField
              ? LocalizationService.translateText(TextType.showPassword)
              : LocalizationService.translateText(TextType.hidePassword),
          onTap: () async {
            controller.toggleObscureText();
          },
        ),
        keyboardType: TextInputType.visiblePassword,
      ),
    );

    Widget signInButton = Padding(
      padding: const EdgeInsets.only(
        left: AppSpacings.comfortable,
        right: AppSpacings.comfortable,
        top: AppSpacings.vast,
      ),
      child: AdvancedTextButton(
        title: LocalizationService.translateText(TextType.signin).toUpperCase(),
        titleStyle: TextStyle(
          fontWeight: AppFontsWeight.bold,
          fontSize: AppFontsSize.normal,
          color: context.appColors.whiteTextColor,
        ),
        onTap: () async {
          await _onTapSignIn(ref, state);
        },
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        emailInput,
        passwordInput,
        signInButton,
      ],
    );
  }
}

extension SignInFormViewFunc on SignInFormView {
  Future<void> _onTapSignIn(
    WidgetRef ref,
    SignInViewState state,
  ) async {
    SignInViewState state =
        ref.watch(SignInViewProvider.signInViewControllerProvider);

    String? validatePassword = _isValidPassword(state);
    String? validateEmail = _isValidEmail(state);
    String? validatePhone = _isValidPhone(state);
    final signInController =
        ref.read(SignInViewProvider.signInViewControllerProvider.notifier);
    if ((validateEmail == null && validatePassword == null) ||
        (validatePhone == null && validatePassword == null)) {
      signInController.signIn(
        signInRequestDTO: SignInRequestDTO(
          state.emailTFController.text,
          state.passwordTFController.text,
        ),
      );
    } else {
      signInController.validateSignInForm(
        emailErrorText: validateEmail,
        passwordErrorText: validatePassword,
      );
    }
  }

  String? _isValidEmail(
    SignInViewState state,
  ) {
    bool isValid = AppRegex.email.regExp.hasMatch(state.emailTFController.text);
    if (!isValid) {
      return LocalizationService.translateText(TextType.invalidEmail);
    }
    return null;
  }

  String? _isValidPhone(
    SignInViewState state,
  ) {
    bool isValid =
        AppRegex.vietnamPhone.regExp.hasMatch(state.emailTFController.text);
    if (!isValid) {
      return LocalizationService.translateText(TextType.invalidPhone);
    }
    return null;
  }

  String? _isValidPassword(
    SignInViewState state,
  ) {
    bool isValid =
        AppRegex.password.regExp.hasMatch(state.passwordTFController.text);
    if (!isValid) {
      return LocalizationService.translateText(TextType.invalidPassword);
    }
    return null;
  }
}
