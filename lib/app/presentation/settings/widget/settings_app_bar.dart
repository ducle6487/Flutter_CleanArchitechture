import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_architechture/app/presentation/notifications_history/controller/notification_history_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/notifications_history/provider/notification_history_view_provider.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_font_size.dart';
import 'package:flutter_clean_architechture/config/app_fonts.dart';
import 'package:flutter_clean_architechture/config/app_fonts_weight.dart';
import 'package:flutter_clean_architechture/config/app_icons.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/config/app_svg_icons.dart';
import 'package:flutter_clean_architechture/core/localization/controller/localization_controller.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/provider/localization_provider.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/router/enum/router_type.dart';
import 'package:flutter_clean_architechture/core/router/extension/router_extension.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_app_bar.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_app_bar_icon_model.dart';

class SettingsAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SettingsAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalizationState state =
        ref.watch(LocalizationProvider.localizationControllerProvider);

    return state.toggleReload ? content(context, ref) : content(context, ref);
  }

  Widget content(
    BuildContext context,
    WidgetRef ref,
  ) {
    NotificationHistoryViewController controller = ref.watch(
      NotificationHistoryViewProvider
          .notificationHistoryViewControllerProvider.notifier,
    );

    return AdvancedAppBar(
      title: LocalizationService.translateText(TextType.settings),
      leading: AdvancedAppBarIconModel(
        icon: Icon(AppIcons.back.icon),
        tooltip: LocalizationService.translateText(TextType.settings),
        onTap: () async => await _onTap(context: context),
      ),
      actionList: [
        AdvancedAppBarIconModel(
          icon: _getAppBarNotificationIcon(context, ref),
          tooltip: AppStrings.emptyText.text,
          onTap: () => _getAppBarNotificationIconOnTap(context, controller),
        ),
      ],
    );
  }

  void _updateNotifications(NotificationHistoryViewController controller) {
    controller.clearNewNotification();
  }

  Future<void> _getAppBarNotificationIconOnTap(
    BuildContext context,
    NotificationHistoryViewController controller,
  ) async {
    _updateNotifications(controller);
    context.pushNamed(RouterType.notificationHistory.name);
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

  /// Represents app bar the leading button tap event.
  Future<void> _onTap({required BuildContext context}) async {
    context.closePage();
  }
}
