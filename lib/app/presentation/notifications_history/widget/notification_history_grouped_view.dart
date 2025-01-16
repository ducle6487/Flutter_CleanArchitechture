import 'package:flutter_clean_architechture/app/presentation/notifications_history/controller/notification_history_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/notifications_history/provider/notification_history_view_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/notifications_history/widget/notification_history_item_view.dart';
import 'package:flutter_clean_architechture/config/app_font_size.dart';
import 'package:flutter_clean_architechture/config/app_fonts.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_divider_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationHistoryGroupedView extends ConsumerWidget {
  final int groupIndex;

  const NotificationHistoryGroupedView({
    super.key,
    required this.groupIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NotificationHistoryViewController controller = ref.watch(
      NotificationHistoryViewProvider
          .notificationHistoryViewControllerProvider.notifier,
    );

    Widget notificationHistoryList = ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller
          .getNotificationsHistoryGrouped()[groupIndex]
          .notifications
          .length,
      itemBuilder: (context, index) {
        return NotificationHistoryItemView(
          id: controller
              .getNotificationsHistoryGrouped()[groupIndex]
              .notifications[index]
              .id,
          onTap: () {
            final notification = controller
                .getNotificationsHistoryGrouped()[groupIndex]
                .notifications[index];
            controller.markAsReadNotification(notificationId: notification.id);

            _handleNotificationAction(
              notification.accessId,
              notification.notificationTypeCode,
              ref,
              notification.description,
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          color: controller
                      .getNotificationsHistoryGrouped()[groupIndex]
                      .notifications[index]
                      .isSeen ??
                  false
              ? context.appColors.backgroundColor
              : context.appColors.oppacityPrimaryColor,
          child: const AdvancedHorizontalDivider(
            padding: EdgeInsets.only(
              left: AppSpacings.spacious,
              right: AppSpacings.compact,
            ),
          ),
        );
      },
    );

    Widget title = Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacings.comfortable,
        horizontal: AppSpacings.comfortable,
      ),
      child: Text(
        controller
            .getNotificationsHistoryGrouped()[groupIndex]
            .title
            .toUpperCase(),
        style: const TextStyle(
          fontSize: AppFontsSize.mediumLarge,
          fontFamily: AppFonts.bigShoudersDisplayFont,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        notificationHistoryList,
      ],
    );
  }

  void _handleNotificationAction(
    String? id,
    String? action,
    WidgetRef ref,
    String? content,
  ) {
    switch (action) {
      default:
        break;
    }
  }
}
