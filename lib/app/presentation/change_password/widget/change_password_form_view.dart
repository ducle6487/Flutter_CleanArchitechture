import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/presentation/change_password/controller/change_password_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/change_password/provider/change_password_view_provider.dart';
import 'package:flutter_clean_architechture/config/app_font_size.dart';
import 'package:flutter_clean_architechture/config/app_fonts_weight.dart';
import 'package:flutter_clean_architechture/config/app_regex.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/config/app_svg_icons.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_button_with_text.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_textfield_form.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_border_model.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_icon_button_model.dart';
import '../../../domain/auth/model/change_password_request_dto.dart';

class ChangePasswordFormView extends ConsumerWidget {
  const ChangePasswordFormView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ChangePasswordViewState state = ref
        .watch(ChangePasswordViewProvider.changePasswordViewControllerProvider);

    ChangePasswordViewController controller = ref.watch(
        ChangePasswordViewProvider
            .changePasswordViewControllerProvider.notifier);

    Widget currentPasswordInput = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.comfortable,
      ),
      child: AdvancedTextFieldForm(
        obscureText: state.oldPasswordObscure,
        textEditingController:
            state.currentPasswordTFController, // Controller for text input
        focusNode:
            state.currentPasswordFocusNode, // Focus node for controlling focus
        hintText: LocalizationService.translateText(
              TextType.enterPassword,
            ) +
            AppStrings.required.text, // Hint text
        validator: state.currentPasswordErrorText,
        onFieldSubmitted: (value) async {
          controller.validateChangePasswordForm(
            currentPasswordErrorText: _isValidPassword(state),
            newPasswordErrorText: state.newPasswordErrorText,
            repeatPasswordErrorText: state.repeatNewPasswordErrorText,
          );
        },
        keyboardType: TextInputType.visiblePassword,
        suffixIconButton: AdvancedIconButtonModel(
          svgIcon: state.oldPasswordObscure
              ? AppSvgIcons.eyeShow.svg
              : AppSvgIcons.eyeHide.svg,
          tooltip: state.oldPasswordObscure
              ? LocalizationService.translateText(TextType.showPassword)
              : LocalizationService.translateText(TextType.hidePassword),
          onTap: () async {
            controller.toggleOldPasswordObscure();
          },
        ),
      ),
    );

    Widget newPasswordInput = Padding(
      padding: const EdgeInsets.all(
        AppSpacings.comfortable,
      ),
      child: AdvancedTextFieldForm(
        obscureText: state.newPasswordObscure,
        textEditingController:
            state.newPasswordTFController, // Controller for text input
        focusNode:
            state.newPasswordFocusNode, // Focus node for controlling focus
        hintText: LocalizationService.translateText(
              TextType.enterNewPassword,
            ) +
            AppStrings.required.text, // Hint text
        validator: state.newPasswordErrorText,
        onFieldSubmitted: (value) async {
          controller.validateChangePasswordForm(
            currentPasswordErrorText: state.currentPasswordErrorText,
            newPasswordErrorText: _isValidNewPassword(state),
            repeatPasswordErrorText: state.repeatNewPasswordErrorText,
          );
        },
        keyboardType: TextInputType.visiblePassword,
        suffixIconButton: AdvancedIconButtonModel(
          svgIcon: state.newPasswordObscure
              ? AppSvgIcons.eyeShow.svg
              : AppSvgIcons.eyeHide.svg,
          tooltip: state.newPasswordObscure
              ? LocalizationService.translateText(TextType.showPassword)
              : LocalizationService.translateText(TextType.hidePassword),
          onTap: () async {
            controller.toggleNewPasswordObscure();
          },
        ),
      ),
    );

    Widget repeatNewPasswordInput = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.comfortable,
      ),
      child: AdvancedTextFieldForm(
        obscureText: state.repeatNewPasswordObscure,
        textEditingController:
            state.repeatNewPasswordTFController, // Controller for text input
        focusNode: state
            .repeatNewPasswordFocusNode, // Focus node for controlling focus
        hintText: LocalizationService.translateText(
              TextType.reEnterNewPassword,
            ) +
            AppStrings.required.text, // Hint text
        validator: state.repeatNewPasswordErrorText,
        onFieldSubmitted: (value) async {
          controller.validateChangePasswordForm(
            currentPasswordErrorText: state.currentPasswordErrorText,
            newPasswordErrorText: state.newPasswordErrorText,
            repeatPasswordErrorText: _isValidRepeatPassword(state),
          );
        },
        keyboardType: TextInputType.visiblePassword,
        suffixIconButton: AdvancedIconButtonModel(
          svgIcon: state.repeatNewPasswordObscure
              ? AppSvgIcons.eyeShow.svg
              : AppSvgIcons.eyeHide.svg,
          tooltip: state.repeatNewPasswordObscure
              ? LocalizationService.translateText(TextType.showPassword)
              : LocalizationService.translateText(TextType.hidePassword),
          onTap: () async {
            controller.toggleRepeatNewPasswordObscure();
          },
        ),
      ),
    );

    Widget changeButton = Padding(
      padding: const EdgeInsets.only(
        left: AppSpacings.comfortable,
        right: AppSpacings.comfortable,
        top: AppSpacings.vast,
      ),
      child: AdvancedTextButton(
        title: LocalizationService.translateText(TextType.saveChange)
            .toUpperCase(),
        titleStyle: TextStyle(
          fontWeight: AppFontsWeight.bold,
          fontSize: AppFontsSize.normal,
          color: context.appColors.whiteTextColor,
        ),
        onTap: () => _onTapSaveChange(
          ref,
          state,
          controller,
        ),
        border: const AdvancedBorderModel(hasBorder: false),
      ),
    );

    Widget content = Padding(
      padding: const EdgeInsets.only(
        top: AppSpacings.comfortable,
      ),
      child: Column(
        children: [
          currentPasswordInput,
          newPasswordInput,
          repeatNewPasswordInput,
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacings.vast,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          content,
          changeButton,
        ],
      ),
    );
  }
}

extension ChangePasswordFormViewFunc on ChangePasswordFormView {
  Future<void> _onTapSaveChange(
    WidgetRef ref,
    ChangePasswordViewState state,
    ChangePasswordViewController controller,
  ) async {
    String? validateCurrentPassword = _isValidPassword(state);
    String? validateNewPassword = _isValidNewPassword(state);
    String? validateRepeatNewPassword = _isValidRepeatPassword(state);

    if (validateCurrentPassword == null &&
        validateNewPassword == null &&
        validateRepeatNewPassword == null) {
      final changePasswordController = ref.read(ChangePasswordViewProvider
          .changePasswordViewControllerProvider.notifier);
      changePasswordController.changePassword(
        changePasswordRequestDTO: ChangePasswordRequestDTO(
          state.currentPasswordTFController.text,
          state.newPasswordTFController.text,
          state.repeatNewPasswordTFController.text,
        ),
        ref: ref,
      );
    } else {
      controller.validateChangePasswordForm(
        currentPasswordErrorText: validateCurrentPassword,
        newPasswordErrorText: validateNewPassword,
        repeatPasswordErrorText: validateRepeatNewPassword,
      );
    }
  }

  String? _isValidPassword(ChangePasswordViewState state) {
    String password = state.currentPasswordTFController.text;

    if (password.isEmpty) {
      return LocalizationService.translateText(TextType.emptyPassword);
    }
    if (!AppRegex.password.regExp.hasMatch(password)) {
      return LocalizationService.translateText(TextType.invalidPassword);
    }

    return null;
  }

  String? _isValidNewPassword(ChangePasswordViewState state) {
    String password = state.newPasswordTFController.text;

    if (password.isEmpty) {
      return LocalizationService.translateText(TextType.emptyNewPassword);
    }
    if (!AppRegex.password.regExp.hasMatch(password)) {
      return LocalizationService.translateText(TextType.invalidPassword);
    }

    return null;
  }

  String? _isValidRepeatPassword(ChangePasswordViewState state) {
    String repeatPassword = state.repeatNewPasswordTFController.text;
    String newPassword = state.newPasswordTFController.text;

    if (repeatPassword.isEmpty) {
      return LocalizationService.translateText(TextType.emptyRepeatNewPassword);
    }
    if (repeatPassword != newPassword) {
      return LocalizationService.translateText(
        TextType.passwordNotMatch,
      );
    }

    return null;
  }
}
