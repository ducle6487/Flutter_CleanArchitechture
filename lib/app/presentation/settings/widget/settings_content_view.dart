import 'package:flutter_clean_architechture/app/presentation/profile_setting/provider/profile_setting_view_provider.dart';
import 'package:flutter_clean_architechture/core/storage/service/shared_preference_service.dart';
import 'package:flutter_clean_architechture/core/theme/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_clean_architechture/app/presentation/settings/controller/settings_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/settings/provider/settings_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/settings/widget/settings_profile_section_view.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_font_size.dart';
import 'package:flutter_clean_architechture/config/app_fonts_weight.dart';
import 'package:flutter_clean_architechture/config/app_resources.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/config/app_svg_icons.dart';
import 'package:flutter_clean_architechture/core/localization/controller/localization_controller.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/router/enum/router_type.dart';
import 'package:flutter_clean_architechture/core/router/extension/router_extension.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/config/app_icons.dart';
import 'package:flutter_clean_architechture/core/localization/provider/localization_provider.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_list_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/core/dialog/dialog_service.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_refresh_indicator.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsContentView extends ConsumerStatefulWidget {
  const SettingsContentView({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettingsContentViewState();
}

class _SettingsContentViewState extends ConsumerState<SettingsContentView> {
  @override
  Widget build(BuildContext context) {
    LocalizationState state =
        ref.watch(LocalizationProvider.localizationControllerProvider);

    ref.listen(
      SettingsViewProvider.settingsViewControllerProvider,
      (previous, next) {
        if (next.isSignOutError) {
          DialogService().signOutErrorDialog();
        }
      },
    );

    return state.toggleReload ? content(context, ref) : content(context, ref);
  }

  Widget content(
    BuildContext context,
    WidgetRef ref,
  ) {
    SettingsViewState state =
        ref.watch(SettingsViewProvider.settingsViewControllerProvider);

    SettingsViewController controller = ref.watch(
      SettingsViewProvider.settingsViewControllerProvider.notifier,
    );

    Widget shimmerTitle = AdvancedShimmer(
      height: AppDimensions.shimmerLineHeight,
      width: AppDimensions.shimmerLineWidthShortest,
    );

    Widget accountSection = Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacings.roomy),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacings.compact),
            child: state.isLoading
                ? shimmerTitle
                : Text(
                    LocalizationService.translateText(TextType.settings),
                    style: TextStyle(
                      fontWeight: AppFontsWeight.semiBold,
                      color: context.appColors.textColor,
                    ),
                  ),
          ),
          Column(
            children: List.generate(
              AppDimensions.settingAccountSectionItemCount,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(top: AppSpacings.tight),
                  child: AdvancedListTile(
                    isFirst: index == 0,
                    isLast: index ==
                        AppDimensions.settingAccountSectionItemCount - 1,
                    isLoading: state.isLoading,
                    title: _getAccountSectionItemTitle(index: index),
                    leadingWidget:
                        _getAccountSectionItemLeadingWidget(index: index),
                    trailingWidget:
                        _getAccountSectionItemTrailingWidget(index: index),
                    onTap: _getAccountSectionItemOnTap(
                      index: index,
                      ref: ref,
                      context: context,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );

    Widget optionSection = Padding(
      padding: const EdgeInsets.all(AppSpacings.roomy),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacings.compact),
            child: state.isLoading
                ? shimmerTitle
                : Text(
                    LocalizationService.translateText(
                      TextType.settingAndOption,
                    ),
                    style: TextStyle(
                      fontWeight: AppFontsWeight.semiBold,
                      color: context.appColors.textColor,
                    ),
                  ),
          ),
          Column(
            children: List.generate(
              AppDimensions.settingOptionSectionItemCount,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(top: AppSpacings.tight),
                  child: AdvancedListTile(
                    isFirst: index == 0,
                    isLast: index ==
                        AppDimensions.settingOptionSectionItemCount - 1,
                    isLoading: state.isLoading,
                    title: _getOptionSectionItemTitle(index: index),
                    leadingWidget:
                        _getOptionSectionItemLeadingWidget(index: index),
                    trailingWidget:
                        _getOptionSectionItemTrailingWidget(index: index),
                    onTap: _getOptionSectionItemOnTap(
                      index: index,
                      ref: ref,
                      context: context,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );

    Widget supportSection = Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacings.roomy),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacings.compact),
            child: state.isLoading
                ? shimmerTitle
                : Text(
                    LocalizationService.translateText(TextType.support),
                    style: TextStyle(
                      fontWeight: AppFontsWeight.semiBold,
                      color: context.appColors.textColor,
                    ),
                  ),
          ),
          Column(
            children: List.generate(
              AppDimensions.settingSupportSectionItemCount,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(top: AppSpacings.tight),
                  child: AdvancedListTile(
                    isFirst: index == 0,
                    isLast: index ==
                        AppDimensions.settingSupportSectionItemCount - 1,
                    isLoading: state.isLoading,
                    title: _getSupportSectionItemTitle(index: index),
                    leadingWidget:
                        _getSupportSectionItemLeadingWidget(index: index),
                    trailingWidget:
                        _getSupportSectionItemTrailingWidget(index: index),
                    onTap: _getSupportSectionItemOnTap(
                      index: index,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );

    Widget logOutTile = Padding(
      padding: const EdgeInsets.only(
        top: AppSpacings.roomy,
        right: AppSpacings.roomy,
        bottom: AppSpacings.spacious,
        left: AppSpacings.roomy,
      ),
      child: AdvancedListTile(
        isFirst: true,
        isLast: true,
        isLoading: state.isLoading,
        title: LocalizationService.translateText(TextType.signOut),
        leadingIcon: AppIcons.signOut.icon,
        onTap: () => _signOut(),
      ),
    );

    return AdvancedRefreshIndicator(
      content: Column(
        children: [
          SettingProfileSectionView(
            isLoading: state.isLoading,
            onTap: () => _openProfileSettingView(),
          ),
          const SizedBox(
            height: AppSpacings.comfortable,
          ),
          accountSection,
          optionSection,
          supportSection,
          logOutTile,
        ],
      ),
      onRefresh: () async {
        controller.getMyProfile();
      },
    );
  }

  /// Get the title of the list tile.
  String? _getAccountSectionItemTitle({
    required int index,
  }) {
    return switch (index) {
      // 0 => LocalizationService.translateText(TextType.darkMode),
      0 => LocalizationService.translateText(TextType.profile),
      _ => null,
    };
  }

  String? _getOptionSectionItemTitle({
    required int index,
  }) {
    return switch (index) {
      // 0 => LocalizationService.translateText(TextType.darkMode),
      0 => LocalizationService.translateText(TextType.notification),
      1 => LocalizationService.translateText(TextType.darkMode),
      2 => LocalizationService.translateText(TextType.language),
      _ => null,
    };
  }

  String? _getSupportSectionItemTitle({
    required int index,
  }) {
    return switch (index) {
      // 0 => LocalizationService.translateText(TextType.darkMode),
      // 0 => LocalizationService.translateText(TextType.supportCenter),
      0 => LocalizationService.translateText(TextType.termsOfUse),
      _ => null,
    };
  }

  /// Get the leading icon of the list tile.
  Widget? _getAccountSectionItemLeadingWidget({required int index}) {
    return switch (index) {
      // 0 => AppIcons.darkModeIcon,
      0 => SvgPicture.asset(
          AppSvgIcons.profile.svg,
          colorFilter: ColorFilter.mode(
            context.appColors.textColor,
            BlendMode.srcIn,
          ),
        ),
      _ => null,
    };
  }

  Widget? _getOptionSectionItemLeadingWidget({required int index}) {
    return switch (index) {
      // 0 => AppIcons.darkModeIcon,
      0 => SvgPicture.asset(
          AppSvgIcons.bell.svg,
          colorFilter: ColorFilter.mode(
            context.appColors.textColor,
            BlendMode.srcIn,
          ),
        ),
      1 => SvgPicture.asset(
          AppSvgIcons.darkMode.svg,
          colorFilter: ColorFilter.mode(
            context.appColors.textColor,
            BlendMode.srcIn,
          ),
        ),
      2 => SvgPicture.asset(
          AppSvgIcons.language.svg,
          colorFilter: ColorFilter.mode(
            context.appColors.textColor,
            BlendMode.srcIn,
          ),
        ),
      _ => null,
    };
  }

  Widget? _getSupportSectionItemLeadingWidget({required int index}) {
    return switch (index) {
      // 0 => AppIcons.darkModeIcon,
      // 0 => SvgPicture.asset(AppSvgIcons.supportCenter.svg),
      0 => SvgPicture.asset(
          AppSvgIcons.termOfUse.svg,
          colorFilter: ColorFilter.mode(
            context.appColors.textColor,
            BlendMode.srcIn,
          ),
        ),
      _ => null,
    };
  }

  /// Get the trailing icon of the list tile.
  Widget? _getAccountSectionItemTrailingWidget({required int index}) {
    return switch (index) {
      // 0 => AppIcons.darkModeIcon,
      0 => Padding(
          padding: const EdgeInsets.only(right: AppSpacings.cozy),
          child: SvgPicture.asset(
            AppSvgIcons.chevron.svg,
            colorFilter: ColorFilter.mode(
              context.appColors.textColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      _ => null,
    };
  }

  Widget? _getOptionSectionItemTrailingWidget({required int index}) {
    return switch (index) {
      // 0 => AppIcons.darkModeIcon,
      0 => Padding(
          padding: const EdgeInsets.only(right: AppSpacings.cozy),
          child: SvgPicture.asset(AppSvgIcons.chevron.svg),
        ),
      1 => Padding(
          padding: const EdgeInsets.only(right: AppSpacings.compact),
          child: SizedBox(
            height: AppDimensions.switchHeight,
            child: Transform.scale(
              scale: .8,
              child: CupertinoSwitch(
                value: ref
                        .watch(ThemeProvider.themeControllerProvider)
                        .themeMode ==
                    ThemeMode.dark,
                onChanged: (bool value) async {
                  HapticFeedback.selectionClick();

                  // Read the ThemeController and update the theme
                  final controller =
                      ref.read(ThemeProvider.themeControllerProvider.notifier);

                  // Determine the new theme mode based on the switch's value
                  ThemeMode newThemeMode =
                      value ? ThemeMode.dark : ThemeMode.light;

                  // Update the theme mode in the controller
                  controller.themeMode = newThemeMode;

                  // Save the new theme mode asynchronously in shared preferences
                  await SharedPreferenceService.setTheme(
                    themeMode: newThemeMode,
                  );
                },
              ),
            ),
          ),
        ),
      2 => Padding(
          padding: const EdgeInsets.only(right: AppSpacings.cozy),
          child: _getLanguageTrailingWidget(),
        ),
      _ => null,
    };
  }

  Widget? _getSupportSectionItemTrailingWidget({required int index}) {
    return switch (index) {
      0 => Padding(
          padding: const EdgeInsets.only(right: AppSpacings.cozy),
          child: SvgPicture.asset(
            AppSvgIcons.chevron.svg,
            colorFilter: ColorFilter.mode(
              context.appColors.textColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      _ => null,
    };
  }

  Widget? _getLanguageTrailingWidget() {
    return Row(
      children: [
        Image(
          image: LocalizationService.getLanguageFlagIcon() as AssetImage,
          height: AppDimensions.settingIconSize,
        ),
        const SizedBox(
          width: AppSpacings.squishy,
        ),
        Text(
          LocalizationService.getLanguageText() ?? AppStrings.emptyText.text,
          style: const TextStyle(
            fontWeight: AppFontsWeight.semiBold,
            fontSize: AppFontsSize.smallMedium,
          ),
        ),
        SvgPicture.asset(
          AppSvgIcons.chevron.svg,
          colorFilter: ColorFilter.mode(
            context.appColors.textColor,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }

  Future<void> Function()? _getAccountSectionItemOnTap({
    required int index,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    return switch (index) {
      0 => () => _openProfileSettingView(),
      _ => null,
    };
  }

  Future<void> Function()? _getOptionSectionItemOnTap({
    required int index,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    return switch (index) {
      // 0 => () => _changeTheme(index: index, ref: ref),
      0 => null,
      1 => null,
      2 => () => _openLanguageSettingsView(),
      _ => null,
    };
  }

  Future<void> Function()? _getSupportSectionItemOnTap({
    required int index,
  }) {
    return switch (index) {
      // 0 => () => _changeTheme(index: index, ref: ref),
      0 => () => _openTermOfUseView(),
      _ => null,
    };
  }

  Future<void> _openLanguageSettingsView() async {
    context.openPage(screenType: RouterType.languageSettings);
  }

  Future<void> _signOut() async {
    SettingsViewController settingsViewController =
        ref.watch(SettingsViewProvider.settingsViewControllerProvider.notifier);
    settingsViewController.signOut(ref);
  }

  Future<void> _openProfileSettingView() async {
    ref
        .watch(ProfileSettingViewProvider.profileSettingViewProvider.notifier)
        .getMyProfile();
    context.openPage(screenType: RouterType.profileSetting);
  }

  Future<void> _openTermOfUseView() async {
    await launchUrl(
      Uri.parse(AppResources.termsOfUseUrl),
    );
  }
}
