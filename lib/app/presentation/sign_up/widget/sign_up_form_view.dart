import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/data/gender/gender.dart';
import 'package:flutter_clean_architechture/app/domain/auth/model/sign_up_request_dto.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_in/enum/sign_in_validate_type.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_up/controller/sign_up_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_up/provider/sign_up_view_provider.dart';
import 'package:flutter_clean_architechture/config/app_font_size.dart';
import 'package:flutter_clean_architechture/config/app_fonts_weight.dart';
import 'package:flutter_clean_architechture/config/app_formatter.dart';
import 'package:flutter_clean_architechture/config/app_regex.dart';
import 'package:flutter_clean_architechture/config/app_resources.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/config/app_svg_icons.dart';
import 'package:flutter_clean_architechture/core/environment/service/environment_service.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_button_with_text.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_check_box.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_date_time_picker.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_dropdown.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_textfield_form.dart';
import 'package:flutter_clean_architechture/core/dialog/dialog_service.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_border_model.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_dropdown_item_model.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_icon_button_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpFormView extends ConsumerWidget {
  const SignUpFormView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SignUpViewController controller =
        ref.watch(SignUpViewProvider.signUpViewControllerProvider.notifier);
    SignUpViewState state =
        ref.watch(SignUpViewProvider.signUpViewControllerProvider);

    List<AdvancedDropdownItemModel> genderDropdownItems =
        Gender.values.map((gender) {
      return AdvancedDropdownItemModel(
        title: LocalizationService.translateText(
          TextType.values.byName(gender.name),
        ), // Extract country name
        icon: null, // You can add an icon based on the country code if needed
        value: gender,
      );
    }).toList();

    Widget emailInput = Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacings.comfortable),
      child: AdvancedTextFieldForm(
        textEditingController:
            state.emailTFController, // Controller for text input
        focusNode: state.emailFocusNode, // Focus node for controlling focus
        hint: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: LocalizationService.translateText(TextType.email),
                style: TextStyle(
                  fontSize: AppFontsSize.normal,
                  color: context.appColors.borderColor,
                ),
              ),
              TextSpan(
                text: AppStrings.required.text,
                style: TextStyle(
                  color: context.appColors.errorColor,
                ), // Red color for asterisk
              ),
            ],
          ),
        ),
        maxLines: 1, // Maximum lines allowed in the text field
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: context.appColors.textColor),
      ),
    );

    Widget passwordInput = AdvancedTextFieldForm(
      obscureText: state.isObscureTextField,
      textEditingController:
          state.passwordTFController, // Controller for text input
      focusNode: state.passwordFocusNode, // Focus node for controlling focus
      hint: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: LocalizationService.translateText(TextType.password),
              style: TextStyle(
                fontSize: AppFontsSize.normal,
                color: context.appColors.borderColor,
              ),
            ),
            TextSpan(
              text: AppStrings.required.text,
              style: TextStyle(
                color: context.appColors.errorColor,
              ), // Red color for asterisk
            ),
          ],
        ),
      ),
      maxLines: 1, // Maximum lines allowed in the text field
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(color: context.appColors.textColor),
      suffixIconButton: AdvancedIconButtonModel(
        svgIcon: state.isObscureTextField
            ? AppSvgIcons.eyeShow.svg
            : AppSvgIcons.eyeHide.svg,
        color: context.appColors.textColor,
        tooltip: state.isObscureTextField
            ? LocalizationService.translateText(TextType.showPassword)
            : LocalizationService.translateText(TextType.hidePassword),
        onTap: () async {
          controller.toggleObscureText();
        },
      ),
    );

    Widget phoneInput = Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacings.comfortable),
      child: AdvancedTextFieldForm(
        textEditingController:
            state.phoneTFController, // Controller for text input
        focusNode: state.phoneFocusNode, // Focus node for controlling focus
        hint: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: LocalizationService.translateText(TextType.phone),
                style: TextStyle(
                  fontSize: AppFontsSize.normal,
                  color: context.appColors.borderColor,
                ),
              ),
              TextSpan(
                text: AppStrings.required.text,
                style: TextStyle(
                  color: context.appColors.errorColor,
                ), // Red color for asterisk
              ),
            ],
          ),
        ), // Hint text
        maxLines: 1, // Maximum lines allowed in the text field
        keyboardType: TextInputType.phone,
        style: TextStyle(color: context.appColors.textColor),
      ),
    );

    Widget addressInput = AdvancedTextFieldForm(
      textEditingController:
          state.addressTFController, // Controller for text input
      focusNode: state.addressFocusNode, // Focus node for controlling focus
      hint: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: LocalizationService.translateText(TextType.address),
              style: TextStyle(
                fontSize: AppFontsSize.normal,
                color: context.appColors.borderColor,
              ),
            ),
          ],
        ),
      ),
      maxLines: 1, // Maximum lines allowed in the text field
      style: TextStyle(color: context.appColors.textColor),
      keyboardType: TextInputType.streetAddress,
    );

    Widget genderDropdown = AdvancedDropdown(
      options: genderDropdownItems,
      selectedItem: state.selectedGender,
      canvasColor: context.appColors.backgroundColor,
      hint: Text(
        LocalizationService.translateText(TextType.gender),
        style: TextStyle(
          color: context.appColors.borderColor,
        ),
      ),
      onChanged: (model) => onChangedGender(model, controller),
    );

    Widget dayOfBirthPicker = Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacings.comfortable),
      child: AdvancedDateTimePicker(
        hintText: LocalizationService.translateText(TextType.dayOfBirth),
        value: state.selectedDayOfBirth,
        formatString: AppFormatter.dateTime.format,
        onChanged: (date) async {
          if (date != state.selectedDayOfBirth) {
            controller.selectedDayOfBirth = date;
          }
        },
      ),
    );

    Widget agreement = Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacings.comfortable),
      child: Row(
        children: [
          AdvancedCheckBox(
            isHighlight: state.isSelectedAgreementHighlight,
            isSelected: state.isSelectedAgreement,
            onPress: () {
              controller.isSelectedAgreement = !state.isSelectedAgreement;
              if (state.isSelectedAgreement) {
                controller.isSelectedAgreementHighlight = false;
              }
            },
          ),
          const SizedBox(
            width: AppSpacings.compact,
          ),
          RichText(
              text: TextSpan(
            style: TextStyle(
              fontWeight: AppFontsWeight.regular,
              fontSize: AppFontsSize.medium,
              color: context.appColors.textColor,
            ),
            children: [
              TextSpan(
                text:
                    "${LocalizationService.translateText(TextType.agreeWith)} ",
                style: const TextStyle(
                  fontSize: AppFontsSize.smallMedium,
                ),
              ),
              TextSpan(
                text: LocalizationService.translateText(TextType.termsOfUse),
                style: TextStyle(
                  fontSize: AppFontsSize.smallMedium,
                  decoration: TextDecoration.underline,
                  color: context.appColors.primaryColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await launchUrl(
                      Uri.parse(AppResources.termsOfUseUrl),
                    );
                  },
              ),
            ],
          ))
        ],
      ),
    );

    Widget signUpButton = Padding(
      padding: const EdgeInsets.only(
        top: AppSpacings.spacious,
      ),
      child: AdvancedTextButton(
        title: LocalizationService.translateText(TextType.signUp).toUpperCase(),
        titleStyle: TextStyle(
          fontWeight: AppFontsWeight.bold,
          fontSize: AppFontsSize.normal,
          color: context.appColors.whiteTextColor,
        ),
        onTap: () async {
          await _onTapSignUp(ref, context);
        },
        border: const AdvancedBorderModel(hasBorder: false),
      ),
    );

    return Column(
      children: [
        emailInput,
        passwordInput,
        phoneInput,
        addressInput,
        dayOfBirthPicker,
        genderDropdown,
        agreement,
        signUpButton
      ],
    );
  }
}

extension on SignUpFormView {
  Future<void> onChangedGender(
    AdvancedDropdownItemModel? model,
    SignUpViewController controller,
  ) async {
    // selectedCountry = model;
    controller.selectedGender = model;
  }

  Future<void> _onTapSignUp(WidgetRef ref, BuildContext context) async {
    SignUpViewState state =
        ref.watch(SignUpViewProvider.signUpViewControllerProvider);
    SignUpViewController controller =
        ref.watch(SignUpViewProvider.signUpViewControllerProvider.notifier);

    if (_isValidEmail(state) &&
        _isValidPassword(state) &&
        _isValidPhone(state) &&
        // _isValidAddress(state) &&
        // _isValidBirthDay(state) &&
        state.isSelectedAgreement) {
      SignUpRequestDTO signUpRequestDTO = SignUpRequestDTO(
        int.parse(EnvironmentService.orgId),
        state.emailTFController.text,
        state.passwordTFController.text,
        state.phoneTFController.text,
        state.addressTFController.text,
        state.selectedGender?.value.value,
        state.selectedDayOfBirth,
      );
      controller.signUp(signUpRequestDTO);
    } else {
      if (state.emailTFController.text.isEmpty) {
        DialogService().authInValidDialog(AuthValidateType.emptyEmail);
        return;
      }
      if (!_isValidEmail(state)) {
        DialogService().authInValidDialog(AuthValidateType.invalidEmail);
        return;
      }
      if (state.passwordTFController.text.isEmpty) {
        DialogService().authInValidDialog(AuthValidateType.emptyPassword);
        return;
      }
      if (!_isValidPassword(state)) {
        DialogService().authInValidDialog(AuthValidateType.invalidPassword);
        return;
      }
      if (state.phoneTFController.text.isEmpty) {
        DialogService().authInValidDialog(AuthValidateType.emptyPhone);
        return;
      }
      if (!_isValidPhone(state)) {
        DialogService().authInValidDialog(AuthValidateType.invalidPhone);
        return;
      }

      if (!state.isSelectedAgreement) {
        controller.isSelectedAgreementHighlight = true;
        DialogService()
            .authInValidDialog(AuthValidateType.disagreeWithTermsOfUse);
        return;
      }
    }
  }

  bool _isValidEmail(SignUpViewState state) {
    return AppRegex.email.regExp.hasMatch(state.emailTFController.text);
  }

  bool _isValidPhone(SignUpViewState state) {
    return AppRegex.vietnamPhone.regExp.hasMatch(state.phoneTFController.text);
  }

  bool _isValidPassword(SignUpViewState state) {
    return AppRegex.password.regExp.hasMatch(state.passwordTFController.text);
  }
}
