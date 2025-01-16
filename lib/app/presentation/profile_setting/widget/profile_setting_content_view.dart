import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/profile_setting/controller/profile_setting_view_controller.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/profile_setting/provider/profile_setting_view_provider.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/profile_setting/widget/profile_setting_form_view.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/profile_setting/widget/profile_setting_info_view.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/settings/provider/settings_provider.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_font_size.dart';
import 'package:Flutter_CleanArchitechture/config/app_icons.dart';
import 'package:Flutter_CleanArchitechture/config/app_icons_image.dart';
import 'package:Flutter_CleanArchitechture/config/app_spacings.dart';
import 'package:Flutter_CleanArchitechture/config/app_strings.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:Flutter_CleanArchitechture/core/pick_image/pick_image_service.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_shimmer.dart';

class ProfileSettingContentView extends ConsumerWidget {
  const ProfileSettingContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfileSettingViewState state =
        ref.watch(ProfileSettingViewProvider.profileSettingViewProvider);
    ProfileSettingViewController controller = ref
        .watch(ProfileSettingViewProvider.profileSettingViewProvider.notifier);

    Widget avatar = Padding(
      padding: EdgeInsets.only(
        bottom: state.isEditing ? AppDimensions.zero : AppSpacings.roomy,
      ),
      child: Container(
        height: AppDimensions.profileSettingLargeAvatarImageSize,
        width: AppDimensions.profileSettingLargeAvatarImageSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppDimensions.profileSettingLargeAvatarImageSize,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: FadeInImage(
          height: AppDimensions.profileSettingLargeAvatarImageSize,
          width: AppDimensions.profileSettingLargeAvatarImageSize,
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
              height: AppDimensions.profileSettingLargeAvatarImageSize,
              width: AppDimensions.profileSettingLargeAvatarImageSize,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );

    Widget changeAvatar = GestureDetector(
      onTap: () async {
        await PickImageService().showOptions(
          context,
          ref,
          () async {
            final imageURL = await PickImageService().getImageFromGallery();
            if (imageURL != null) {
              await controller.updateMyAvatar(avatarUrl: imageURL);
              ref
                  .watch(SettingsViewProvider
                      .settingsViewControllerProvider.notifier)
                  .getMyProfile();
            }
          },
          () async {
            final imageURL = await PickImageService().getImageFromCamera();
            if (imageURL != null) {
              await controller.updateMyAvatar(avatarUrl: imageURL);
              ref
                  .watch(SettingsViewProvider
                      .settingsViewControllerProvider.notifier)
                  .getMyProfile();
            }
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacings.squishy,
              vertical: AppSpacings.tight,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  AppDimensions.profileSettingLargeAvatarImageSize),
              color: context.appColors.primaryColor,
              border: Border.all(
                color: context.appColors.primaryColor,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: AppSpacings.compact,
                ),
                Icon(
                  AppIcons.camera.icon,
                  size: AppDimensions.listTileLeadingIconSize,
                  color: context.appColors.textColor,
                ),
                Text(
                  ' | ',
                  style: TextStyle(
                    fontSize: AppFontsSize.large,
                    color: context.appColors.reverseBackgroundColor,
                  ),
                ),
                Text(
                  LocalizationService.translateText(TextType.changeAvatar),
                  style: TextStyle(
                    color: context.appColors.reverseBackgroundColor,
                  ),
                ),
                const SizedBox(
                  width: AppSpacings.compact,
                ),
              ],
            ),
          )
        ],
      ),
    );

    Widget avatarShimmer = AdvancedShimmer(
      height: AppDimensions.profileSettingLargeAvatarImageSize,
      width: AppDimensions.profileSettingLargeAvatarImageSize,
      radius: AppDimensions.profileSettingLargeAvatarImageSize,
    );

    Widget avatarWrapper = Center(
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacings.spacious),
        child: state.isLoading
            ? avatarShimmer
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  state.userProfileResponseDTO != null ? avatar : avatar,
                  if (!state.isEditing) changeAvatar,
                ],
              ),
      ),
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacings.roomy),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avatarWrapper,
            state.isEditing
                ? const ProfileSettingFormView()
                : const ProfileSettingInfoView(),
          ],
        ),
      ),
    );
  }
}
