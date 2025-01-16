import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_clean_architechture/app/data/gender/gender.dart';
import 'package:flutter_clean_architechture/app/presentation/profile_setting/controller/profile_setting_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/profile_setting/provider/profile_setting_view_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_in/enum/sign_in_validate_type.dart';
import 'package:flutter_clean_architechture/config/app_formatter.dart';
import 'package:flutter_clean_architechture/config/app_regex.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/core/dialog/dialog_service.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_date_time_picker.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_dropdown.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_shimmer.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_textfield_form.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_dropdown_item_model.dart';
import '../../../../config/app_dimensions.dart';
import '../../../../config/app_font_size.dart';
import '../../../../config/app_fonts_weight.dart';
import '../../../../config/app_radius.dart';
import '../../../../core/widgets/advanced_button_with_text.dart';
import '../../../../core/widgets/model/advanced_border_model.dart';

class ProfileSettingFormView extends ConsumerWidget {
  const ProfileSettingFormView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfileSettingViewState state =
        ref.watch(ProfileSettingViewProvider.profileSettingViewProvider);

    ProfileSettingViewController controller = ref
        .watch(ProfileSettingViewProvider.profileSettingViewProvider.notifier);

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

    Widget nameInput = AdvancedTextFieldForm(
      textEditingController:
          state.nameTFController, // Controller for text input
      focusNode: state.nameFocusNode, // Focus node for controlling focus
      hint: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: LocalizationService.translateText(TextType.fullName),
              style: TextStyle(
                fontSize: AppFontsSize.normal,
                color: context.appColors.textColor,
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
      keyboardType: TextInputType.name,
      isLoading: state.isLoading,
      validator: state.nameErrorText,
    );

    Widget emailInput = AdvancedTextFieldForm(
      textEditingController:
          state.emailTFController, // Controller for text input
      focusNode: FocusNode(), // Focus node for controlling focus
      hint: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: LocalizationService.translateText(TextType.email),
              style: TextStyle(
                fontSize: AppFontsSize.normal,
                color: context.appColors.textColor,
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
      isReadOnly: true,
      isLoading: state.isLoading,
    );

    Widget phoneInput = AdvancedTextFieldForm(
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
                color: context.appColors.textColor,
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
      keyboardType: TextInputType.text,
      isLoading: state.isLoading,
    );

    Widget addressInput = AdvancedTextFieldForm(
      textEditingController:
          state.addressTFController, // Controller for text input
      focusNode: state.addressFocusNode, // Focus node for controlling focus
      hintText:
          LocalizationService.translateText(TextType.address), // Hint text
      maxLines: 3,
      minLines: 1, // Maximum lines allowed in the text field
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      isLoading: state.isLoading,
    );

    Widget genderDropdown = AdvancedDropdown(
      options: genderDropdownItems,
      selectedItem: state.selectedGender?.title == AppStrings.emptyText.text
          ? (state.selectedGender?.value == Gender.male
              ? genderDropdownItems.first
              : genderDropdownItems.last)
          : state.selectedGender,
      canvasColor: context.appColors.backgroundColor,
      hint: Text(
        LocalizationService.translateText(TextType.gender),
        style: TextStyle(
          color: context.appColors.borderColor,
        ),
      ),
      onChanged: (model) => onChangedGender(model, controller),
      isLoading: state.isLoading,
    );

    Widget dayOfBirthPicker = AdvancedDateTimePicker(
      hintText: LocalizationService.translateText(TextType.dayOfBirth),
      value: state.selectedDayOfBirth,
      formatString: AppFormatter.dateTime.format,
      onChanged: (date) async {
        if (date != state.selectedDayOfBirth) {
          controller.selectedDayOfBirth = date;
        }
      },
      isLoading: state.isLoading,
    );

    Widget saveChangesButton = SizedBox(
      width: context.width / 2,
      child: AdvancedTextButton(
        title: LocalizationService.translateText(
          TextType.saveChange,
        ),
        titleStyle: TextStyle(
          fontWeight: AppFontsWeight.bold,
          fontSize: AppFontsSize.normal,
          color: context.appColors.whiteTextColor,
        ),
        onTap: () => _onTapSaveChange(
          ref: ref,
          context: context,
          controller: controller,
          state: state,
        ),
        border: const AdvancedBorderModel(hasBorder: false),
      ),
    );

    Widget buildShimmer = Column(
      children: [
        const SizedBox(
          height: AppSpacings.roomy,
        ),
        AdvancedShimmer(
          height: AppDimensions.shimmerLineHeight,
          radius: AppRadius.large,
        ),
        const SizedBox(
          height: AppSpacings.roomy,
        ),
        AdvancedShimmer(
          height: AppDimensions.shimmerLineHeight,
          radius: AppRadius.large,
        ),
        const SizedBox(
          height: AppSpacings.roomy,
        ),
        AdvancedShimmer(
          height: AppDimensions.shimmerLineHeight,
          radius: AppRadius.large,
        ),
        const SizedBox(
          height: AppSpacings.roomy,
        ),
        AdvancedShimmer(
          height: AppDimensions.shimmerLineHeight,
          radius: AppRadius.large,
        ),
      ],
    );

    Widget content = Column(
      children: [
        const SizedBox(
          height: AppSpacings.spacious,
        ),
        nameInput,
        const SizedBox(
          height: AppSpacings.comfortable,
        ),
        dayOfBirthPicker,
        const SizedBox(
          height: AppSpacings.comfortable,
        ),
        emailInput,
        const SizedBox(
          height: AppSpacings.comfortable,
        ),
        phoneInput,
        const SizedBox(
          height: AppSpacings.comfortable,
        ),
        genderDropdown,
        const SizedBox(
          height: AppSpacings.comfortable,
        ),
        addressInput,
        const SizedBox(
          height: AppSpacings.spacious,
        ),
        saveChangesButton,
      ],
    );

    return state.isLoading ? buildShimmer : content;
  }
}

extension on ProfileSettingFormView {
  Future<void> _onTapSaveChange({
    required ProfileSettingViewController controller,
    required ProfileSettingViewState state,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    if (isValid(state, controller)) {
      controller.nameErrorText = null;
      controller.updateMyProfile(
        ref: ref,
      );
    }
  }

  bool isValid(
    ProfileSettingViewState state,
    ProfileSettingViewController controller,
  ) {
    if (state.nameTFController.text.isEmpty) {
      DialogService().authInValidDialog(AuthValidateType.emptyFullName);
      return false;
    }

    if (state.emailTFController.text.isEmpty) {
      DialogService().authInValidDialog(AuthValidateType.emptyEmail);
      return false;
    }

    if (!AppRegex.email.regExp.hasMatch(state.emailTFController.text)) {
      DialogService().authInValidDialog(AuthValidateType.invalidEmail);
      return false;
    }

    if (state.phoneTFController.text.isEmpty) {
      DialogService().authInValidDialog(AuthValidateType.emptyPhone);
      return false;
    }

    if (!AppRegex.vietnamPhone.regExp.hasMatch(state.phoneTFController.text)) {
      DialogService().authInValidDialog(AuthValidateType.invalidPhone);
      return false;
    }

    return true;
  }

  Future<void> onChangedGender(
    AdvancedDropdownItemModel? model,
    ProfileSettingViewController controller,
  ) async {
    controller.selectedGender = model;
  }
}
