import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/presentation/notifications_history/controller/notification_history_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/notifications_history/provider/notification_history_view_provider.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_font_size.dart';
import 'package:flutter_clean_architechture/config/app_icons_image.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/core/extension/datetime.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';

class NotificationHistoryItemView extends ConsumerWidget {
  final String id;
  final Function()? onTap;

  const NotificationHistoryItemView({
    super.key,
    required this.id,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NotificationHistoryViewController controller = ref.watch(
      NotificationHistoryViewProvider
          .notificationHistoryViewControllerProvider.notifier,
    );
    Widget icon = Image(image: AppIconsImage.notification.asset);

    Widget contentSpacing = const SizedBox(
      width: AppSpacings.compact,
    );

    Widget description = Text(
      controller.notificationHistoryBy(id)?.description ??
          AppStrings.emptyText.text,
      maxLines: AppDimensions.notiDescriptionLines,
      overflow: TextOverflow.ellipsis, // Truncate with "..."
    );

    Widget createdAt = Text(
      controller.notificationHistoryBy(id)?.createdAt?.timeAgo() ??
          AppStrings.emptyText.text,
      style: TextStyle(
        fontSize: AppFontsSize.small,
        color: context.appColors.disableColor,
      ),
    );

    Widget contentWrapper = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          description,
          const SizedBox(
            height: AppSpacings.squishy,
          ),
          createdAt,
        ],
      ),
    );

    Widget content = GestureDetector(
      onTap: onTap,
      child: Container(
        color: controller.notificationHistoryBy(id)?.isSeen ?? false
            ? context.appColors.backgroundColor
            : context.appColors.oppacityPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacings.comfortable),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              contentSpacing,
              contentWrapper,
            ],
          ),
        ),
      ),
    );

    return content;
  }
}
