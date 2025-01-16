import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/presentation/verify/controller/verify_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/verify/provider/verify_view_provider.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_font_size.dart';
import 'package:flutter_clean_architechture/config/app_fonts.dart';
import 'package:flutter_clean_architechture/config/app_fonts_weight.dart';
import 'package:flutter_clean_architechture/config/app_radius.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_button_with_text.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_textfield_form.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_border_model.dart';

class VerifyFormView extends ConsumerWidget {
  const VerifyFormView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = MediaQuery.sizeOf(context).width;

    VerifyViewController controller =
        ref.watch(VerifyViewProvider.verifyViewControllerProvider.notifier);
    VerifyViewState state =
        ref.watch(VerifyViewProvider.verifyViewControllerProvider);

    void nextField(int index, String value) {
      if (value.length == 1) {
        if (index < state.controllers.length - 1) {
          FocusScope.of(context).requestFocus(state.focusNodes[index + 1]);
        } else if (index == state.controllers.length - 1) {
          state.focusNodes[index].unfocus();
          _verifyButtonTap(controller);
        } else {
          state.focusNodes[index].unfocus();
          // Optionally, perform any action after entering the last digit.
        }
      } else {
        if (index > 0) {
          FocusScope.of(context).requestFocus(state.focusNodes[index - 1]);
        } else if (index == 0) {
          FocusScope.of(context).requestFocus(state.focusNodes[0]);
        } else {
          state.focusNodes[0].unfocus();
        }
      }
    }

    Widget title = Align(
      alignment: Alignment.centerLeft,
      child: Text(
        LocalizationService.translateText(TextType.verifyTitle),
        style: TextStyle(
          color: context.appColors.backgroundColor,
          fontFamily: AppFonts.bigShoudersDisplayFont,
          fontSize: AppFontsSize.xxLarge,
          fontWeight: AppFontsWeight.bold,
        ),
      ),
    );

    Widget description = Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacings.comfortable),
      child: Text(
        LocalizationService.translateText(TextType.verifyDescFirst) +
            state.email +
            LocalizationService.translateText(TextType.verifyDescSecond),
        style: TextStyle(
          color: context.appColors.backgroundColor,
          fontSize: AppFontsSize.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );

    Widget otpTextField(
      TextEditingController controller,
      FocusNode focusNode,
      int index,
    ) {
      return Container(
        width: AppDimensions.otpTFSizePercent * width,
        height: AppDimensions.otpTFSizePercent * width,
        padding: const EdgeInsets.all(AppSpacings.tight),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppRadius.medium),
          ),
          border: Border.all(
            width: 1,
            color: context.appColors.borderColor,
          ),
        ),
        child: AdvancedTextFieldForm(
          style: TextStyle(
            color: context.appColors.backgroundColor,
            fontSize: AppFontsSize.mediumLarge,
          ),
          textAlign: TextAlign.center,
          hintText: "",
          maxLength: 1,
          textEditingController: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          border: const AdvancedBorderModel(hasBorder: false),
          onChanged: (value) async => nextField(index, value),
        ),
      );
    }

    Widget otpFieldSection = Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacings.roomy,
        horizontal: AppSpacings.cozy,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          AppDimensions.otpBoxCount,
          (index) {
            return otpTextField(
                state.controllers[index], state.focusNodes[index], index);
          },
        ),
      ),
    );

    Widget reSendDescription = Padding(
      padding: const EdgeInsets.only(
          top: AppSpacings.vast, bottom: AppSpacings.spacious),
      child: Text(
        LocalizationService.translateText(
          TextType.verifyResendDesc,
        ),
        style: TextStyle(
          color: context.appColors.textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );

    Widget verifyButton = AdvancedTextButton(
      title: LocalizationService.translateText(TextType.verify).toUpperCase(),
      titleStyle: const TextStyle(
          fontWeight: AppFontsWeight.bold, fontSize: AppFontsSize.normal),
      onTap: () async => _verifyButtonTap(controller),
      border: const AdvancedBorderModel(hasBorder: false),
    );

    Widget reSendButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacings.roomy),
      child: AdvancedTextButton(
        title: LocalizationService.translateText(TextType.verifyResend)
                .toUpperCase() +
            _getRemainingTime(ref),
        titleStyle: const TextStyle(
            fontWeight: AppFontsWeight.bold, fontSize: AppFontsSize.normal),
        onTap: state.remaining > 0 ? null : () async => _resentOTP(controller),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacings.comfortable),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title,
          description,
          otpFieldSection,
          reSendDescription,
          reSendButton,
          verifyButton,
        ],
      ),
    );
  }

  Future<void> _verifyButtonTap(VerifyViewController controller) async {
    controller.verify();
  }

  Future<void> _resentOTP(VerifyViewController controller) async {
    return controller.resentOTP();
  }

  String _getRemainingTime(WidgetRef ref) {
    VerifyViewState state =
        ref.watch(VerifyViewProvider.verifyViewControllerProvider);
    if (state.remaining == 0) {
      return "";
    }

    int mins = state.remaining ~/ 60;
    int secs = (state.remaining % 60);

    String formattedMins = mins.toString().padLeft(2, '0');
    String formattedSecs = secs.toString().padLeft(2, '0');

    return ' ($formattedMins:$formattedSecs)';
  }
}
