import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/settings/controller/settings_view_controller.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/settings/provider/settings_provider.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_font_size.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts_weight.dart';
import 'package:Flutter_CleanArchitechture/config/app_icons_image.dart';
import 'package:Flutter_CleanArchitechture/config/app_radius.dart';
import 'package:Flutter_CleanArchitechture/config/app_spacings.dart';
import 'package:Flutter_CleanArchitechture/config/app_strings.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_shimmer.dart';

class SettingProfileSectionView extends ConsumerWidget {
  final bool isLoading;
  final void Function()? onTap;
  const SettingProfileSectionView({
    super.key,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    SettingsViewState state =
        ref.watch(SettingsViewProvider.settingsViewControllerProvider);

    Widget avatar = Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(AppDimensions.settingAvatarImageSize),
      ),
      clipBehavior: Clip.hardEdge,
      child: FadeInImage(
        height: AppDimensions.settingAvatarImageSize,
        width: AppDimensions.settingAvatarImageSize,
        fit: BoxFit.cover,
        placeholderColorBlendMode: BlendMode.difference,
        image: NetworkImage(
          state.userProfileResponseDTO?.profile?.avatarUrl ??
              AppStrings.emptyText.text,
        ),
        placeholder: AppIconsImage.defaultAvatar.asset,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image(
            image: AppIconsImage.defaultAvatar.asset,
            height: AppDimensions.settingAvatarImageSize,
            width: AppDimensions.settingAvatarImageSize,
            fit: BoxFit.cover,
          );
        },
      ),
    );

    Widget name = Text(
      state.userProfileResponseDTO?.profile?.fullName ??
          AppStrings.emptyText.text,
      style: const TextStyle(
        fontWeight: AppFontsWeight.semiBold,
      ),
    );

    Widget email = Text(
      state.userProfileResponseDTO?.email ?? AppStrings.emptyText.text,
      style: const TextStyle(fontSize: AppFontsSize.small),
    );

    Widget content = GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSpacings.roomy,
          right: AppSpacings.roomy,
          top: AppSpacings.comfortable,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: context.appColors.appBarColor,
            borderRadius: BorderRadius.circular(
              AppRadius.large,
            ),
          ),
          padding: const EdgeInsets.all(AppSpacings.compact),
          child: Row(
            children: [
              avatar,
              const SizedBox(
                width: AppSpacings.compact,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    name,
                    email,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    Widget shimmer = Padding(
      padding: const EdgeInsets.only(
        left: AppSpacings.roomy,
        right: AppSpacings.roomy,
        top: AppSpacings.roomy,
      ),
      child: AdvancedShimmer(
        height: AppDimensions.shimmerLineHeightMediumLarge,
        radius: AppSpacings.cozy,
      ),
    );

    return isLoading ? shimmer : content;
  }
}
