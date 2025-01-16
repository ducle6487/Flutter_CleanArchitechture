import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/presentation/forgot_password/enum/forgot_password_radio_button_options.dart';
import 'package:flutter_clean_architechture/app/presentation/forgot_password/widget/forgot_password_reset_with_email_view.dart';
import 'package:flutter_clean_architechture/config/app_font_size.dart';
import 'package:flutter_clean_architechture/config/app_fonts.dart';
import 'package:flutter_clean_architechture/config/app_fonts_weight.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_radio_button.dart';
import '../../../../core/widgets/advanced_button_with_text.dart';
import '../../../../core/widgets/model/advanced_border_model.dart';
import '../controller/forgot_password_view_controller.dart';
import '../enum/forgot_password_view_type.dart';
import '../provider/forgot_password_view_provider.dart';

class ForgotPasswordMethodView extends ConsumerWidget {
  const ForgotPasswordMethodView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ForgotPasswordViewController controller = ref.watch(
        ForgotPasswordViewProvider
            .forgotPasswordViewControllerProvider.notifier);
    var radioOptions =
        ForgotPasswordRadioButtonOptions.values.map((e) => e).toList();
    ForgotPasswordViewState state = ref
        .watch(ForgotPasswordViewProvider.forgotPasswordViewControllerProvider);

    Future<void> onTapOk() async {
      controller.viewType = state.radioButtonSelected ==
                  LocalizationService.translateText(radioOptions.first.value) ||
              state.radioButtonSelected == null
          ? ForgotPasswordViewType.email
          : ForgotPasswordViewType.phone;
    }

    Widget title = Padding(
      padding: const EdgeInsets.only(
        left: AppSpacings.comfortable,
      ),
      child: Text(
        LocalizationService.translateText(TextType.forgotPasswordTitle),
        style: const TextStyle(
          fontFamily: AppFonts.bigShoudersDisplayFont,
          fontSize: AppFontsSize.xxLarge,
          fontWeight: AppFontsWeight.bold,
        ),
      ),
    );

    Widget content = Padding(
      padding: const EdgeInsets.only(left: AppSpacings.comfortable),
      child: Text(
        LocalizationService.translateText(TextType.forgotPasswordContent),
        style: const TextStyle(
          fontFamily: AppFonts.helveticaNeueFont,
          fontSize: AppFontsSize.normal,
          fontWeight: AppFontsWeight.regular,
        ),
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

    Widget radioButton = Padding(
      padding: const EdgeInsets.only(
          left: AppSpacings.comfortable, top: AppSpacings.compact),
      child: AdvancedRadioButtonView(
          options: radioOptions
              .map(
                (e) => LocalizationService.translateText(e.value),
              )
              .toList(),
          selectedOption: state.radioButtonSelected ??
              LocalizationService.translateText(radioOptions.first.value),
          titleStyle: const TextStyle(
            fontFamily: AppFonts.helveticaNeueFont,
            fontSize: AppFontsSize.normal,
            fontWeight: AppFontsWeight.regular,
          ),
          onChanged: (value) {
            controller.radioButtonSelected = value;
          }),
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
        onTap: () => onTapOk(),
        border: const AdvancedBorderModel(hasBorder: false),
      ),
    );

    Widget selectMethodView = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWrapper,
        radioButton,
        okButton,
      ],
    );

    Widget contentSelectMethodView = AnimatedSwitcher(
      duration: Durations.medium1,
      transitionBuilder: (Widget child, Animation<double> animation) =>
          ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: selectMethodView,
    );

    Widget contentEmailView = AnimatedSwitcher(
      duration: Durations.medium1,
      transitionBuilder: (Widget child, Animation<double> animation) =>
          ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: const ForgotPasswordResetWithEmailView(),
    );

    Widget view = state.viewType == ForgotPasswordViewType.selectMethod
        ? contentSelectMethodView
        : contentEmailView;

    return view;
  }
}
