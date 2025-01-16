import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_icons_image.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/core/localization/enum/language_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/storage/service/shared_preference_service.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/config/app_icons.dart';
import 'package:flutter_clean_architechture/core/localization/provider/localization_provider.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsLanguageContentView extends ConsumerWidget {
  SettingsLanguageContentView({super.key});

  Future<void> Function()? _getOnTap({
    required int index,
    required WidgetRef ref,
  }) {
    return switch (index) {
      _ => () => _changeLocalize(index: index, ref: ref),
    };
  }

  final languages = LanguageType.values.map((e) => e.getLocale());

  /// Get the title of the list tile.
  String? _getTitle({
    required int index,
  }) {
    return switch (index) {
      _ => LocalizationService.translateText(
          TextType.values.firstWhere(
            (e) =>
                e.name.toString().toUpperCase().compareTo(
                      languages.toList()[index].countryCode ??
                          AppStrings.emptyText.text,
                    ) ==
                AppDimensions.zero,
          ),
        ),
    };
  }

  /// Get the subtitle of the list tile.
  String? _getSubtitle({
    required int index,
  }) {
    return switch (index) {
      _ => '',
    };
  }

  AssetImage? _getLeadingWidget(int index) {
    return switch (languages.toList()[index].languageCode) {
      'en' => AppIconsImage.ukFlag.asset,
      _ => AppIconsImage.vnFlag.asset,
    };
  }

  /// Get the leading icon of the list tile.
  IconData? _getTrailingIcon({
    required int index,
    required WidgetRef ref,
    required BuildContext context,
  }) {
    final localizationState =
        ref.watch(LocalizationProvider.localizationControllerProvider);
    return switch (index) {
      _ => (languages.toList()[index].countryCode ?? AppStrings.emptyText.text)
                  .compareTo(
                      localizationState.languageType.region.toLowerCase()) ==
              AppDimensions.zero
          ? AppIcons.checked.icon
          : null,
    };
  }

  Future<void> _changeLocalize({
    required int index,
    required WidgetRef ref,
  }) async {
    final localizationController =
        ref.watch(LocalizationProvider.localizationControllerProvider.notifier);

    final newLanguageType = LanguageType.values.firstWhere(
      (element) =>
          element.region.compareTo(
            languages.toList()[index].countryCode ?? AppStrings.emptyText.text,
          ) ==
          AppDimensions.zero,
    );

    await localizationController.changeLanguage(languageType: newLanguageType);
    await SharedPreferenceService.setLanguage(languageType: newLanguageType);
    localizationController.reload();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacings.comfortable),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: AppSpacings.tight,
        ),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return AdvancedListTile(
            title: _getTitle(index: index),
            subtitle: _getSubtitle(index: index),
            leadingWidget: Image(
              image: _getLeadingWidget(index) as AssetImage,
              height: AppDimensions.iconSize,
            ),
            trailingIcon:
                _getTrailingIcon(index: index, ref: ref, context: context),
            trailingIconColor: context.appColors.textColor,
            onTap: _getOnTap(
              index: index,
              ref: ref,
            ),
            onLongPress: null,
          );
        },
      ),
    );
  }
}
