import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_clean_architechture/app/presentation/profile_setting/controller/profile_setting_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/profile_setting/provider/profile_setting_view_provider.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_font_size.dart';
import 'package:flutter_clean_architechture/config/app_fonts_weight.dart';
import 'package:flutter_clean_architechture/config/app_formatter.dart';
import 'package:flutter_clean_architechture/config/app_icons_image.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/config/app_svg_icons.dart';
import 'package:flutter_clean_architechture/core/authorization/service/authorization_service.dart';
import 'package:flutter_clean_architechture/core/dialog/dialog_service.dart';
import 'package:flutter_clean_architechture/core/extension/string.dart';
import 'package:flutter_clean_architechture/core/loading/provider/loading_provider.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/router/enum/router_type.dart';
import 'package:flutter_clean_architechture/core/router/extension/router_extension.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_button_with_text.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_list_tile.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_shimmer.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_border_model.dart';

class ProfileSettingInfoView extends ConsumerStatefulWidget {
  const ProfileSettingInfoView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileSettingInfoViewState();
}

class _ProfileSettingInfoViewState
    extends ConsumerState<ProfileSettingInfoView> {
  @override
  Widget build(BuildContext context) {
    ProfileSettingViewState state = ref.watch(
      ProfileSettingViewProvider.profileSettingViewProvider,
    );

    ProfileSettingViewController controller = ref.watch(
      ProfileSettingViewProvider.profileSettingViewProvider.notifier,
    );

    Widget profileHeader = Padding(
      padding: const EdgeInsets.only(
        top: AppSpacings.spacious,
        bottom: AppSpacings.compact,
      ),
      child: Text(
        LocalizationService.translateText(TextType.profile),
        style: TextStyle(
          fontWeight: AppFontsWeight.semiBold,
          color: context.appColors.textColor,
        ),
      ),
    );

    Widget nameTile = AdvancedListTile(
      isFirst: true,
      title: state.userProfileResponseDTO?.profile?.fullName ??
          AppStrings.emptyText.text,
      leadingWidget: SvgPicture.asset(
        AppSvgIcons.profile.svg,
        colorFilter: ColorFilter.mode(
          context.appColors.textColor,
          BlendMode.srcIn,
        ),
      ),
      isLoading: state.isLoading,
      onTap: null,
    );

    Widget dateOfBirthTile = AdvancedListTile(
      title: state.userProfileResponseDTO?.profile?.birthDay?.isNotEmpty != null
          ? AppFormatter.dateTime.formatter.format(
              (state.userProfileResponseDTO?.profile?.birthDay ??
                      AppStrings.emptyText.text)
                  .toDateTime(),
            )
          : AppStrings.emptyText.text,
      leadingWidget: SvgPicture.asset(
        AppSvgIcons.candle.svg,
        colorFilter: ColorFilter.mode(
          context.appColors.textColor,
          BlendMode.srcIn,
        ),
      ),
      isLoading: state.isLoading,
      onTap: null,
    );

    Widget emailTile = AdvancedListTile(
      title: state.userProfileResponseDTO?.email ?? AppStrings.emptyText.text,
      leadingWidget: SvgPicture.asset(
        AppSvgIcons.mail.svg,
        colorFilter: ColorFilter.mode(
          context.appColors.textColor,
          BlendMode.srcIn,
        ),
      ),
      isLoading: state.isLoading,
      onTap: null,
    );

    Widget phoneTile = AdvancedListTile(
      title: state.userProfileResponseDTO?.phone ?? AppStrings.emptyText.text,
      leadingWidget: SvgPicture.asset(
        AppSvgIcons.phone.svg,
        colorFilter: ColorFilter.mode(
          context.appColors.textColor,
          BlendMode.srcIn,
        ),
      ),
      isLoading: state.isLoading,
      onTap: null,
    );

    Widget genderTile = AdvancedListTile(
      title: state.userProfileResponseDTO?.profile?.gender != null
          ? state.userProfileResponseDTO!.profile!.gender!
              ? LocalizationService.translateText(TextType.male)
              : LocalizationService.translateText(TextType.female)
          : AppStrings.emptyText.text,
      leadingWidget: SvgPicture.asset(
        AppSvgIcons.gender.svg,
        colorFilter: ColorFilter.mode(
          context.appColors.textColor,
          BlendMode.srcIn,
        ),
      ),
      isLoading: state.isLoading,
      onTap: null,
    );

    Widget addressTile = AdvancedListTile(
      isLast: true,
      title: state.userProfileResponseDTO?.profile?.address ??
          AppStrings.emptyText.text,
      leadingWidget: SvgPicture.asset(
        AppSvgIcons.location.svg,
        colorFilter: ColorFilter.mode(
          context.appColors.textColor,
          BlendMode.srcIn,
        ),
      ),
      isLoading: state.isLoading,
      onTap: null,
    );

    Widget securityHeader = Padding(
      padding: const EdgeInsets.only(
        top: AppSpacings.spacious,
        bottom: AppSpacings.compact,
      ),
      child: Text(
        LocalizationService.translateText(TextType.securityInfomation),
        style: TextStyle(
          fontWeight: AppFontsWeight.semiBold,
          color: context.appColors.textColor,
        ),
      ),
    );

    Widget headerShimmer = Padding(
      padding: const EdgeInsets.only(
        top: AppSpacings.spacious,
        bottom: AppSpacings.compact,
      ),
      child: AdvancedShimmer(
        height: AppDimensions.shimmerLineHeight,
        width: AppDimensions.shimmerLineWidthShortest,
      ),
    );

    Widget changePasswordTile = AdvancedListTile(
      isFirst: true,
      isLast: true,
      title: LocalizationService.translateText(TextType.changePassword),
      leadingWidget: SvgPicture.asset(
        AppSvgIcons.lock.svg,
        colorFilter: ColorFilter.mode(
          context.appColors.textColor,
          BlendMode.srcIn,
        ),
      ),
      isLoading: state.isLoading,
      onTap: () => _openChangePassword(context),
      trailingWidget: Padding(
        padding: const EdgeInsets.only(right: AppSpacings.cozy),
        child: SvgPicture.asset(
          AppSvgIcons.chevron.svg,
          colorFilter: ColorFilter.mode(
            context.appColors.textColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );

    Widget deleteAccountTile = AdvancedListTile(
      isFirst: true,
      isLast: true,
      title: LocalizationService.translateText(TextType.deleteAccount),
      titleColor: context.appColors.errorColor,
      leadingWidget: SvgPicture.asset(
        AppSvgIcons.deleteAccount.svg,
        colorFilter: ColorFilter.mode(
          context.appColors.errorColor,
          BlendMode.srcIn,
        ),
      ),
      isLoading: state.isLoading,
      onTap: () => _showConfirmDeleteAccount(),
    );

    Widget editButton = Center(
      child: SizedBox(
        width: context.width / 2,
        child: AdvancedTextButton(
          title: LocalizationService.translateText(TextType.edit),
          titleStyle: TextStyle(
            fontWeight: AppFontsWeight.bold,
            fontSize: AppFontsSize.normal,
            color: context.appColors.whiteTextColor,
          ),
          onTap: () async {
            controller.isEditing = true;
          },
          border: const AdvancedBorderModel(hasBorder: false),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        state.isLoading ? headerShimmer : profileHeader,
        nameTile,
        const SizedBox(
          height: AppSpacings.tight,
        ),
        if (state.selectedDayOfBirth != null)
          Column(
            children: [
              dateOfBirthTile,
              const SizedBox(
                height: AppSpacings.tight,
              ),
            ],
          ),
        emailTile,
        const SizedBox(
          height: AppSpacings.tight,
        ),
        phoneTile,
        const SizedBox(
          height: AppSpacings.tight,
        ),
        if (state.selectedGender != null)
          Column(
            children: [
              genderTile,
              const SizedBox(
                height: AppSpacings.tight,
              )
            ],
          ),
        if (state.addressTFController.text.isNotEmpty)
          Column(
            children: [
              addressTile,
              const SizedBox(
                height: AppSpacings.tight,
              )
            ],
          ),
        state.isLoading ? headerShimmer : securityHeader,
        changePasswordTile,
        const SizedBox(
          height: AppSpacings.tight,
        ),
        deleteAccountTile,
        const SizedBox(
          height: AppSpacings.spacious,
        ),
        if (!state.isLoading) editButton,
        const SizedBox(
          height: AppSpacings.spacious,
        ),
      ],
    );
  }

  Future<void> _openChangePassword(BuildContext context) async {
    context.openPage(screenType: RouterType.changePassword);
  }

  Future<void> _showConfirmDeleteAccount() async {
    DialogService().showNormalDialog(
      isShowCloseButton: true,
      icon: Image(
        image: AppIconsImage.warning.asset,
        height: 65,
        width: 65,
      ),
      title: LocalizationService.translateText(TextType.warning).toUpperCase(),
      content: LocalizationService.translateText(TextType.confirmDeleteAccount),
      isShowYes: true,
      yesBtnTitle: LocalizationService.translateText(TextType.cont),
      onYesPressed: () async {
        final loadingController =
            ref.read(LoadingProvider.loadingControllerProvider.notifier);
        loadingController.isLoading = true;
        final result = await ref
            .watch(
                ProfileSettingViewProvider.profileSettingViewProvider.notifier)
            .deleteAccount();
        loadingController.isLoading = false;
        if (result) {
          await _showDeleteAccountSuccess();
        }
      },
    );
  }

  Future<void> _showDeleteAccountSuccess() async {
    DialogService().showNormalDialog(
      barrierDismissible: false,
      icon: Image(
        image: AppIconsImage.warning.asset,
        height: 90,
        width: 90,
      ),
      title: LocalizationService.translateText(TextType.notification)
          .toUpperCase(),
      content: LocalizationService.translateText(TextType.deletedAccount),
      isShowYes: true,
      yesBtnTitle: LocalizationService.translateText(TextType.ok),
      onYesPressed: () {
        AuthorizationService.instance.clearToken();
      },
    );
  }
}
