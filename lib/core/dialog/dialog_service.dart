import 'dart:ui';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_in/enum/sign_in_validate_type.dart';
import 'package:flutter_clean_architechture/config/app_font_size.dart';
import 'package:flutter_clean_architechture/config/app_fonts.dart';
import 'package:flutter_clean_architechture/config/app_fonts_weight.dart';
import 'package:flutter_clean_architechture/config/app_icons.dart';
import 'package:flutter_clean_architechture/config/app_images.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/config/app_svg_icons.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_button_with_text.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_border_model.dart';
import '../../config/app_dimensions.dart';
import '../../config/app_radius.dart';
import '../widgets/advanced_button_with_icon_text.dart';
import '../widgets/advanced_divider_horizontal.dart';

class DialogService {
  Future<void> showCustomDialogWithCustomContent({
    bool? barrierDismissible,
    Widget? content,
    String? title,
  }) async {
    Get.dialog(
      barrierDismissible: barrierDismissible ?? true,
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppDimensions.blurSigmaX,
          sigmaY: AppDimensions.blurSigmaY,
        ),
        child: AlertDialog(
          backgroundColor: Get.context!.appColors.backgroundColor,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          contentPadding:
              const EdgeInsets.symmetric(vertical: AppSpacings.comfortable),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          shadowColor: Get.context!.appColors.shadowColor,
          content: content,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          titlePadding: const EdgeInsets.only(
            top: AppSpacings.comfortable,
          ),
          title: title != null
              ? Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Get.context!.appColors.primaryColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  showCustomNoActionDialog({
    bool isShowCloseButton = false,
    String? content,
    String? title,
    Widget? customHeader,
  }) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppDimensions.blurSigmaX,
          sigmaY: AppDimensions.blurSigmaY,
        ),
        child: AlertDialog(
          backgroundColor: Get.context!.appColors.backgroundColor,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          titlePadding: const EdgeInsets.only(
            top: 20,
          ),
          contentPadding:
              const EdgeInsets.only(bottom: 40, left: 10, right: 10, top: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          shadowColor: Get.context!.appColors.shadowColor,
          icon: isShowCloseButton
              ? GestureDetector(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      AppIcons.close.icon,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                )
              : null,
          title: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
              children: [
                if (customHeader != null) customHeader,
                if (title != null)
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Get.context!.appColors.primaryColor,
                    ),
                  ),
              ],
            ),
          ),
          content: content == null
              ? null
              : Text(
                  content,
                  textAlign: TextAlign.center,
                ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }

  void showCustomNoActionDialogWithCustomContent({
    Widget? content,
    Widget? title,
  }) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppDimensions.blurSigmaX,
          sigmaY: AppDimensions.blurSigmaY,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return AlertDialog(
              backgroundColor: Get.context!.appColors.backgroundColor,
              titlePadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.xLarge),
              ),
              shadowColor: Get.context!.appColors.shadowColor,
              title: title,
              content: Container(
                constraints: BoxConstraints(
                  maxHeight:
                      Get.height * (2 / 3), // Adjust this value as needed
                ),
                child: SingleChildScrollView(
                  child: content ?? const SizedBox.shrink(),
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              insetPadding: EdgeInsets.zero,
            );
          },
        ),
      ),
    );
  }

  showCustomDialog({
    required String title,
    required String content,
    AssetImage? icon,
    required String buttonText,
    required Future<void> Function() onPressed,
    bool? btnLoading,
    double? width,
    List<Widget>? actions,
    double? iconSize,
    bool barrierDismissible = true,
  }) {
    Get.dialog(
      barrierDismissible: barrierDismissible,
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppDimensions.blurSigmaX,
          sigmaY: AppDimensions.blurSigmaY,
        ),
        child: AlertDialog(
          backgroundColor: Get.context!.appColors.backgroundColor,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          titlePadding: const EdgeInsets.only(
            top: 20,
          ),
          contentPadding:
              const EdgeInsets.only(bottom: 40, left: 10, right: 10, top: 20),
          iconPadding: const EdgeInsets.only(top: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          shadowColor: Get.context!.appColors.shadowColor,
          icon: icon == null
              ? null
              : Image(
                  image: icon,
                  height: iconSize,
                ),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Get.context!.appColors.primaryColor,
            ),
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            SizedBox(
              width: width,
              child: AdvancedTextButton(
                border: const AdvancedBorderModel(hasBorder: false),
                title: buttonText,
                titleStyle: TextStyle(
                  fontSize: AppFontsSize.large,
                  fontWeight: AppFontsWeight.semiBold,
                  color: Get.context!.appColors.whiteTextColor,
                ),
                onTap: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showYesNoDialog({
    required String title,
    required String content,
    AssetImage? icon,
    double? iconSize,
    required Future<void> Function() onYesPressed,
    required Future<void> Function() onNoPressed,
    String? yesTitle,
    String? noTitle,
    double? width,
  }) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppDimensions.blurSigmaX,
          sigmaY: AppDimensions.blurSigmaY,
        ),
        child: AlertDialog(
          backgroundColor: Get.context!.appColors.backgroundColor,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          titlePadding: const EdgeInsets.only(top: 20),
          contentPadding:
              const EdgeInsets.only(bottom: 40, left: 10, right: 10, top: 20),
          iconPadding: const EdgeInsets.only(top: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          shadowColor: Get.context!.appColors.shadowColor,
          icon: icon == null
              ? null
              : Image(
                  image: icon,
                  height: iconSize,
                ),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Get.context!.appColors.primaryColor,
            ),
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            SizedBox(
              width: width,
              child: AdvancedTextButton(
                border: const AdvancedBorderModel(hasBorder: false),
                title:
                    yesTitle ?? LocalizationService.translateText(TextType.yes),
                titleStyle: const TextStyle(
                  fontSize: AppFontsSize.large,
                  fontWeight: AppFontsWeight.semiBold,
                ),
                onTap: () async {
                  onYesPressed();
                  Get.back();
                },
              ),
            ),
            const SizedBox(
              height: AppSpacings.compact,
            ),
            SizedBox(
              width: width,
              child: AdvancedTextButton(
                border: const AdvancedBorderModel(hasBorder: false),
                title:
                    noTitle ?? LocalizationService.translateText(TextType.no),
                titleStyle: TextStyle(
                  fontSize: AppFontsSize.large,
                  fontWeight: AppFontsWeight.semiBold,
                  color: Get.context!.appColors.whiteTextColor,
                ),
                onTap: () async {
                  onNoPressed();
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomModalBottomSheet({
    bool isShowCloseButton = false,
    bool isShowBackgroundImage = false,
    Widget? content,
    Widget? title,
    Widget? customHeader,
    Widget? header,
    String? buttonLeftText,
    String? buttonRightText,
    ImageProvider? buttonLeftImage,
    ImageProvider? buttonRightImage,
    Future<void> Function()? buttonLeftOnTap,
    Future<void> Function()? buttonRightOnTap,
    bool isShowButtonLeft = true,
    bool isShowButtonRight = true,
    bool zeroPadding = false,
    bool isShowButton = true,
    Color? backgroundColor,
    bool isFullScreen = false,
  }) {
    final width = MediaQuery.sizeOf(Get.context!).width;

    Widget headerDefault = Padding(
      padding: const EdgeInsets.all(
        AppSpacings.comfortable,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: AppSpacings.cozy,
            ),
            child: header,
          ),
          const AdvancedHorizontalDivider(),
        ],
      ),
    );

    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor:
          backgroundColor ?? Get.context!.appColors.backgroundColor,
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Get.height * 0.8,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: isFullScreen ? 25 : 0),
            child: Stack(
              children: [
                if (isShowBackgroundImage)
                  Image(
                    image: AppImages.backgroundBottomSheet.asset,
                    fit: BoxFit.cover,
                    width: width,
                  ),
                Container(
                  width: width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        AppRadius.xLarge,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: Get.height * 0.05,
                          ),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: AppSpacings.roomy,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(zeroPadding ? 0 : 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customHeader ?? headerDefault,
                                      if (title != null) title,
                                      const SizedBox(height: 20),
                                      if (content != null) content,
                                    ],
                                  ),
                                ),
                              ),
                              if (isShowCloseButton)
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(Get.context!);
                                    },
                                    child: Icon(
                                      AppIcons.close.icon,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (isShowButton)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacings.comfortable,
                              AppDimensions.zero,
                              AppSpacings.roomy,
                              AppSpacings.comfortable,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  isShowButtonLeft && isShowButtonRight
                                      ? MainAxisAlignment.spaceBetween
                                      : MainAxisAlignment.center,
                              children: [
                                if (isShowButtonLeft)
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: context.appColors.warningColor,
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.medium,
                                      ),
                                    ),
                                    width: context.width * 0.4,
                                    height: AppDimensions
                                        .modalBottomSheetButtonHeightDefault,
                                    child: AdvancedIconTextButton(
                                      title: buttonLeftText ??
                                          AppStrings.emptyText.text,
                                      titleStyle: TextStyle(
                                        color: Get
                                            .context!.appColors.whiteTextColor,
                                        fontWeight: AppFontsWeight.bold,
                                        fontSize: AppFontsSize.normal,
                                      ),
                                      leadingWidget: buttonLeftImage != null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: AppSpacings.tight,
                                                right: AppSpacings.squishy,
                                              ),
                                              child: Image(
                                                image: buttonLeftImage,
                                                width: AppDimensions
                                                    .iconSizeMediumLarge,
                                                height: AppDimensions
                                                    .iconSizeMediumLarge,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : null,
                                      onTap: () async {
                                        context.pop();
                                        if (buttonLeftOnTap != null) {
                                          buttonLeftOnTap();
                                        }
                                      },
                                      border: const AdvancedBorderModel(
                                        hasBorder: false,
                                      ),
                                    ),
                                  ),
                                if (isShowButtonRight)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: context.appColors.errorColor,
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.medium,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    width: context.width * 0.4,
                                    height: AppDimensions
                                        .modalBottomSheetButtonHeightDefault,
                                    child: AdvancedIconTextButton(
                                      title: buttonRightText ??
                                          AppStrings.emptyText.text,
                                      titleStyle: TextStyle(
                                        color: Get
                                            .context!.appColors.whiteTextColor,
                                        fontWeight: AppFontsWeight.bold,
                                        fontSize: AppFontsSize.normal,
                                      ),
                                      leadingWidget: buttonRightImage != null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: AppSpacings.tight,
                                                right: AppSpacings.squishy,
                                              ),
                                              child: Image(
                                                image: buttonRightImage,
                                                width: AppDimensions
                                                    .iconSizeMediumLarge,
                                                height: AppDimensions
                                                    .iconSizeMediumLarge,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : null,
                                      onTap: () async {
                                        context.pop();
                                        if (buttonRightOnTap != null) {
                                          buttonRightOnTap();
                                        }
                                      },
                                      border: const AdvancedBorderModel(
                                        radius: AppRadius.medium,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // implements dialog with situations

  void showNormalDialog({
    Widget? icon,
    String? title,
    String? content,
    bool? isShowNo,
    bool? isShowYes,
    String? yesBtnTitle,
    String? noBtnTitle,
    void Function()? onNoPressed,
    void Function()? onYesPressed,
    bool? barrierDismissible,
    bool? isShowCloseButton,
    bool? notShowingIconBottomPadding,
    Color? contentColor,
    Color? titleColor,
  }) {
    Widget closeButton = InkWell(
      onTap: () {
        Get.context!.pop();
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: AppSpacings.comfortable,
          top: AppSpacings.comfortable,
        ),
        child: SvgPicture.asset(AppSvgIcons.x.svg),
      ),
    );

    showCustomDialogWithCustomContent(
      barrierDismissible: barrierDismissible,
      content: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Image(
            image: AppImages.popupBackground.asset,
            width: Get.context!.width,
            fit: BoxFit.fitWidth,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacings.comfortable,
            ),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: AppSpacings.spacious,
                      ),
                      icon,
                    ],
                  ),
                notShowingIconBottomPadding == true
                    ? const SizedBox.shrink()
                    : const SizedBox(
                        height: AppSpacings.comfortable,
                      ),
                if (title != null)
                  Text(
                    title.toUpperCase(),
                    style: TextStyle(
                      fontSize: AppFontsSize.xxLarge,
                      fontFamily: AppFonts.bigShoudersDisplayFont,
                      color: titleColor,
                      fontWeight: AppFontsWeight.extraBold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                if (content != null)
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppFontsSize.medium,
                      fontWeight: FontWeight.w400,
                      color: contentColor,
                    ),
                  ),
                const SizedBox(
                  height: AppSpacings.spacious,
                ),
                Row(
                  children: [
                    if (isShowNo != null && isShowNo)
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Get.context!.pop();
                            if (onNoPressed != null) {
                              onNoPressed();
                            }
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppRadius.small,
                              ), // Adjust the radius as needed
                            ),
                            backgroundColor: Get.context?.appColors.primaryColor
                                .withOpacity(0.6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacings.cozy,
                            ),
                            child: Text(
                              (noBtnTitle ?? 'No').toString().toUpperCase(),
                              style: TextStyle(
                                fontSize: AppFontsSize.large,
                                fontWeight: FontWeight.w700,
                                color: Get.context?.appColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (isShowNo != null &&
                        isShowYes != null &&
                        isShowNo &&
                        isShowYes)
                      const SizedBox(
                        width: AppSpacings.comfortable,
                      ),
                    if (isShowYes != null && isShowYes)
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Get.context!.pop();
                            if (onYesPressed != null) {
                              onYesPressed();
                            }
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppRadius.small,
                              ), // Adjust the radius as needed
                            ),
                            backgroundColor:
                                Get.context?.appColors.primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacings.cozy,
                            ),
                            child: Text(
                              (yesBtnTitle ?? "Yes").toUpperCase(),
                              style: TextStyle(
                                fontSize: AppFontsSize.medium,
                                fontWeight: FontWeight.w700,
                                color: Get.context?.appColors.backgroundColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: AppSpacings.comfortable,
                ),
              ],
            ),
          ),
          if (isShowCloseButton == true) closeButton,
        ],
      ),
    );
  }

  Future<void> imageSizeTooBigErrorDialog() async {
    showCustomDialog(
      title: LocalizationService.translateText(TextType.warning),
      content: LocalizationService.translateText(TextType.imageSizeTooBig),
      buttonText: LocalizationService.translateText(TextType.ok),
      onPressed: () async {
        Get.back();
      },
    );
  }

  Future<void> signOutErrorDialog() async {
    showCustomDialog(
      title: LocalizationService.translateText(TextType.warning),
      content: LocalizationService.translateText(TextType.someErrorOccurred),
      buttonText: LocalizationService.translateText(TextType.tryAgain),
      onPressed: () async {
        Get.back();
      },
    );
  }

  Future<void> wrongOTPDialog() async {
    showCustomDialog(
      title: LocalizationService.translateText(TextType.warning),
      content: LocalizationService.translateText(TextType.wrongOtp),
      buttonText: LocalizationService.translateText(TextType.tryAgain),
      onPressed: () async {
        Get.back();
      },
    );
  }

  Future<void> failDialog({
    required String message,
    Future<void> Function()? onPress,
  }) async {
    showCustomDialog(
      title: LocalizationService.translateText(TextType.warning),
      content: message,
      buttonText: LocalizationService.translateText(TextType.ok),
      onPressed: () async {
        Get.back();
        if (onPress != null) {
          onPress();
        }
      },
    );
  }

  Future<void> unFollowConfirmDialog({
    required String message,
    Future<void> Function()? onPress,
  }) async {
    showYesNoDialog(
      title: LocalizationService.translateText(TextType.notification),
      content: message,
      onYesPressed: () async {
        if (onPress != null) {
          onPress();
        }
      },
      onNoPressed: () async {},
    );
  }

  Future<void> signUpSuccessDialog({
    required Future<void> Function() onPressed,
  }) async {
    showCustomDialog(
      barrierDismissible: false,
      title: LocalizationService.translateText(TextType.success),
      content: LocalizationService.translateText(TextType.signUpSuccess),
      buttonText: LocalizationService.translateText(TextType.ok),
      onPressed: onPressed,
    );
  }

  Future<void> updateProfileFailDialog() async {
    showCustomDialog(
      title: LocalizationService.translateText(TextType.fail),
      content: LocalizationService.translateText(TextType.updateProfileFail),
      buttonText: LocalizationService.translateText(TextType.tryAgain),
      onPressed: () async {
        Get.back();
      },
    );
  }

  Future<void> updateProfileSuccessDialog() async {
    showCustomDialog(
      title: LocalizationService.translateText(TextType.success),
      content: LocalizationService.translateText(TextType.updateProfileSuccess),
      buttonText: LocalizationService.translateText(TextType.ok),
      onPressed: () async {
        Get.back();
      },
    );
  }

  Future<void> forgotPasswordResetFailDialog() async {
    showCustomDialog(
      title: LocalizationService.translateText(TextType.warning),
      content: LocalizationService.translateText(TextType.forgotPasswordFail),
      buttonText: LocalizationService.translateText(TextType.tryAgain),
      onPressed: () async {
        Get.back();
      },
    );
  }

  Future<void> forgotPasswordResetSuccessDialog({
    required Future<void> Function() onPressed,
  }) async {
    showCustomDialog(
      title: LocalizationService.translateText(TextType.emailSent),
      content:
          LocalizationService.translateText(TextType.forgotPasswordSuccess),
      buttonText: LocalizationService.translateText(TextType.ok),
      onPressed: onPressed,
    );
  }

  Future<void> changePasswordFailDialog() async {
    showCustomDialog(
      title: LocalizationService.translateText(TextType.fail),
      content:
          LocalizationService.translateText(TextType.incorrectCurrentPassword),
      buttonText: LocalizationService.translateText(TextType.tryAgain),
      onPressed: () async {
        Get.back();
      },
    );
  }

  Future<void> changePasswordSuccessDialog() async {
    showCustomDialog(
      title: LocalizationService.translateText(
        TextType.success,
      ),
      content:
          LocalizationService.translateText(TextType.changePasswordSuccess),
      buttonText: LocalizationService.translateText(TextType.ok),
      onPressed: () async {
        Get.back();
      },
    );
  }

  Future<void> authInValidDialog(
    AuthValidateType type,
  ) async {
    showCustomDialog(
      title: LocalizationService.translateText(TextType.warning),
      content: _getAuthInvalidContent(type),
      buttonText: LocalizationService.translateText(TextType.ok),
      onPressed: () async {
        Get.back();
      },
    );
  }

  Future<void> selectServiceFilterDialog({
    required int length,
    required Widget Function(int) item,
  }) async {
    showCustomDialogWithCustomContent(
      content: SizedBox(
        width: Get.width,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          crossAxisSpacing: AppSpacings.comfortable,
          mainAxisSpacing: AppSpacings.comfortable,
          padding:
              const EdgeInsets.symmetric(horizontal: AppSpacings.comfortable),
          childAspectRatio: AppDimensions.serviceFilterItemRatio,
          children: List.generate(
            length,
            (index) {
              return item(index);
            },
          ),
        ),
      ),
      title: LocalizationService.translateText(TextType.filter),
    );
  }

  String _getAuthInvalidContent(
    AuthValidateType type,
  ) {
    return switch (type) {
      AuthValidateType.emptyUsername =>
        LocalizationService.translateText(TextType.emptyUsername),
      AuthValidateType.emptyEmail =>
        LocalizationService.translateText(TextType.emptyEmail),
      AuthValidateType.emptyPassword =>
        LocalizationService.translateText(TextType.emptyPassword),
      AuthValidateType.emptyPhone =>
        LocalizationService.translateText(TextType.emptyPhone),
      AuthValidateType.emptyAddress =>
        LocalizationService.translateText(TextType.emptyAddress),
      AuthValidateType.emptyGender =>
        LocalizationService.translateText(TextType.emptyGender),
      AuthValidateType.emptyBirthDay =>
        LocalizationService.translateText(TextType.emptyBirthDay),
      AuthValidateType.invalidEmail =>
        LocalizationService.translateText(TextType.invalidEmail),
      AuthValidateType.invalidPassword =>
        LocalizationService.translateText(TextType.invalidPassword),
      AuthValidateType.invalidPhone =>
        LocalizationService.translateText(TextType.invalidPhone),
      AuthValidateType.invalidUsername =>
        LocalizationService.translateText(TextType.invalidUsername),
      AuthValidateType.emptyJob =>
        LocalizationService.translateText(TextType.emptyJob),
      AuthValidateType.emptyWorkPlace =>
        LocalizationService.translateText(TextType.emptyWorkPlace),
      AuthValidateType.passwordNotMatch =>
        LocalizationService.translateText(TextType.passwordNotMatch),
      AuthValidateType.emptyNewPassword =>
        LocalizationService.translateText(TextType.emptyNewPassword),
      AuthValidateType.emptyRepeatNewPassword =>
        LocalizationService.translateText(TextType.emptyRepeatNewPassword),
      AuthValidateType.invalidNewPassword =>
        LocalizationService.translateText(TextType.invalidNewPassword),
      AuthValidateType.invalidRepeatNewPassword =>
        LocalizationService.translateText(TextType.invalidRepeatNewPassword),
      AuthValidateType.newPasswordMissingSpecialCharacter =>
        LocalizationService.translateText(
          TextType.newPasswordMissingSpecialCharacter,
        ),
      AuthValidateType.repeatNewPasswordMissingSpecialCharacter =>
        LocalizationService.translateText(
          TextType.repeatNewPasswordMissingSpecialCharacter,
        ),
      AuthValidateType.newPasswordMissingUpperCharacter =>
        LocalizationService.translateText(
          TextType.newPasswordMissingUpperCharacter,
        ),
      AuthValidateType.repeatNewPasswordMissingUpperCharacter =>
        LocalizationService.translateText(
          TextType.repeatNewPasswordMissingUpperCharacter,
        ),
      AuthValidateType.emptyFullName => LocalizationService.translateText(
          TextType.emptyFullName,
        ),
      AuthValidateType.disagreeWithTermsOfUse =>
        LocalizationService.translateText(TextType.needAgreement),
    };
  }
}
