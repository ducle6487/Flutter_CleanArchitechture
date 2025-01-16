import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/notifications_history/controller/notification_history_view_controller.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/notifications_history/provider/notification_history_view_provider.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/settings/controller/settings_view_controller.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/settings/provider/settings_provider.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_font_size.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts.dart';
import 'package:Flutter_CleanArchitechture/config/app_fonts_weight.dart';
import 'package:Flutter_CleanArchitechture/config/app_icons_image.dart';
import 'package:Flutter_CleanArchitechture/config/app_strings.dart';
import 'package:Flutter_CleanArchitechture/config/app_svg_icons.dart';
import 'package:Flutter_CleanArchitechture/core/router/enum/router_type.dart';
import 'package:Flutter_CleanArchitechture/core/router/extension/router_extension.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_app_bar.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_app_bar_icon_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedHomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String? title;

  const AdvancedHomeAppBar({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsViewState state =
        ref.watch(SettingsViewProvider.settingsViewControllerProvider);

    SettingsViewController settingsViewController =
        ref.watch(SettingsViewProvider.settingsViewControllerProvider.notifier);

    NotificationHistoryViewController controller = ref.read(
      NotificationHistoryViewProvider
          .notificationHistoryViewControllerProvider.notifier,
    );

    Widget appBar = AdvancedAppBar(
      title: title,
      leading: null,
      actionList: <AdvancedAppBarIconModel>[
        AdvancedAppBarIconModel(
          icon: _getAppBarNotificationIcon(context, ref),
          tooltip: AppStrings.emptyText.text,
          onTap: () => _getAppBarNotificationIconOnTap(context, controller),
        ),
        AdvancedAppBarIconModel(
          icon: _getAppBarAvatarUserIcon(context, state),
          tooltip: AppStrings.emptyText.text,
          onTap: () =>
              _getAppBarAvatarUserOnTap(context, settingsViewController),
        ),
      ],
    );

    return appBar;
  }

  Widget _getAppBarAvatarUserIcon(
    BuildContext context,
    SettingsViewState state,
  ) {
    return Center(
      child: Container(
        height: AppDimensions.appBarAvatarSize,
        width: AppDimensions.appBarAvatarSize,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.appBarAvatarSize),
          color: context.appColors.appBarColor,
        ),
        child: state.userProfileResponseDTO?.profile?.avatarUrl == null
            ? SvgPicture.asset(
                AppSvgIcons.defaultAvatar.svg,
                height: AppDimensions.appBarAvatarSize,
                width: AppDimensions.appBarAvatarSize,
                colorFilter: ColorFilter.mode(
                  context.appColors.textColor,
                  BlendMode.srcIn,
                ),
              )
            : FadeInImage(
                height: AppDimensions.appBarAvatarSize,
                width: AppDimensions.appBarAvatarSize,
                fit: BoxFit.cover,
                placeholderColorBlendMode: BlendMode.difference,
                image: NetworkImage(
                  state.userProfileResponseDTO?.profile?.avatarUrl ??
                      AppStrings.emptyText.text,
                ),
                placeholder: AppIconsImage.defaultAppbarAvatar.asset,
                imageErrorBuilder: (context, error, stackTrace) {
                  return SvgPicture.asset(
                    AppSvgIcons.defaultAvatar.svg,
                    height: AppDimensions.appBarAvatarSize,
                    width: AppDimensions.appBarAvatarSize,
                  );
                },
              ),
      ),
    );
  }

  Future<void> _getAppBarAvatarUserOnTap(
      BuildContext context, SettingsViewController controller) async {
    controller.getMyProfile();
    context.openPage(screenType: RouterType.setting);
  }

  Future<void> _getAppBarNotificationIconOnTap(
    BuildContext context,
    NotificationHistoryViewController controller,
  ) async {
    _updateNotifications(controller);
    context.openPage(screenType: RouterType.notificationHistory);
  }

  Widget _getAppBarNotificationIcon(BuildContext context, WidgetRef ref) {
    NotificationHistoryViewState state = ref.watch(
      NotificationHistoryViewProvider.notificationHistoryViewControllerProvider,
    );

    return Align(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          SizedBox(
            height: AppDimensions.notificationBellContainerSize,
          ),
          Center(
            child: SizedBox(
              height: AppDimensions.notificationBellSize,
              child: SvgPicture.asset(
                AppSvgIcons.bell.svg,
                width: AppDimensions.appBarIconSize,
                height: AppDimensions.appBarIconSize,
                colorFilter: ColorFilter.mode(
                  context.appColors.textColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Container(
            height: AppDimensions.notiCountSize,
            width: AppDimensions.notiCountSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.notiCountSize),
              color: !state.unreadNotificationsCount.isEqual(AppDimensions.zero)
                  ? context.appColors.errorColor
                  : null,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${state.unreadNotificationsCount}',
                style: TextStyle(
                  height: AppDimensions.textNoPadding,
                  fontSize: AppFontsSize.xxSmall,
                  fontWeight: AppFontsWeight.bold,
                  fontFamily: AppFonts.bigShoudersDisplayFont,
                  color: context.appColors.appBarColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateNotifications(NotificationHistoryViewController controller) {
    controller.clearNewNotification();
  }
}
