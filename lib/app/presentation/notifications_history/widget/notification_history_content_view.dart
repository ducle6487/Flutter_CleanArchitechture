import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/notifications_history/controller/notification_history_view_controller.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/notifications_history/provider/notification_history_view_provider.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/notifications_history/widget/notification_history_grouped_view.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_radius.dart';
import 'package:Flutter_CleanArchitechture/config/app_spacings.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_divider_horizontal.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_empty_view.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_refresh_indicator.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_shimmer.dart';

class NotificationHistoryContentView extends ConsumerStatefulWidget {
  const NotificationHistoryContentView({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationHistoryContentViewState();
}

class _NotificationHistoryContentViewState
    extends ConsumerState<NotificationHistoryContentView> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          setState(() {
            NotificationHistoryViewController controller = ref.watch(
              NotificationHistoryViewProvider
                  .notificationHistoryViewControllerProvider.notifier,
            );
            if (controller.pagination?.nextPage != null) {
              controller.loadMoreNotificationHistory();
            }
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    NotificationHistoryViewController controller = ref.watch(
      NotificationHistoryViewProvider
          .notificationHistoryViewControllerProvider.notifier,
    );
    NotificationHistoryViewState state = ref.watch(
      NotificationHistoryViewProvider.notificationHistoryViewControllerProvider,
    );

    Widget notificationHistoryGroupedList = ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.pagination?.nextPage != null
          ? controller.getNotificationsHistoryGrouped().length +
              AppDimensions.moreIndex
          : controller.getNotificationsHistoryGrouped().length,
      itemBuilder: (context, index) {
        if (state.pagination?.nextPage != null &&
            index == controller.getNotificationsHistoryGrouped().length) {
          return const Center(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                vertical: AppSpacings.comfortable,
              ),
              child: RefreshProgressIndicator(),
            ),
          );
        }
        return NotificationHistoryGroupedView(groupIndex: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const AdvancedHorizontalDivider(
          padding: EdgeInsets.only(
            left: AppSpacings.spacious,
            right: AppSpacings.compact,
          ),
        );
      },
    );

    Widget content = AdvancedRefreshIndicator(
      scrollController: scrollController,
      content: state.notificationsHistory.isEmpty
          ? const AdvancedEmptyView()
          : notificationHistoryGroupedList,
      onRefresh: () async {
        controller.getNotificationHistory();
        controller.getUnreadNotificationsCount();
      },
    );

    Widget shimmerItem = Padding(
      padding: const EdgeInsets.all(AppSpacings.comfortable),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdvancedShimmer(
            width: AppDimensions.appBarIconSize,
            height: AppDimensions.appBarIconSize,
          ),
          const SizedBox(
            width: AppSpacings.compact,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdvancedShimmer(
                  height: AppDimensions.shimmerLineSmallHeight,
                  radius: AppRadius.small,
                ),
                const SizedBox(
                  height: AppSpacings.compact,
                ),
                AdvancedShimmer(
                  height: AppDimensions.shimmerLineSmallHeight,
                  radius: AppRadius.small,
                ),
                const SizedBox(
                  height: AppSpacings.compact,
                ),
                AdvancedShimmer(
                  height: AppDimensions.shimmerLineSmallHeight,
                  width: AppDimensions.shimmerLineWidthShort,
                  radius: AppRadius.small,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget shimmerContent = ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: AppDimensions.shimmerItems,
      itemBuilder: (context, index) {
        return shimmerItem;
      },
      separatorBuilder: (BuildContext context, int index) {
        return const AdvancedHorizontalDivider(
          padding: EdgeInsets.only(
            left: AppSpacings.spacious,
            right: AppSpacings.compact,
          ),
        );
      },
    );

    return state.isLoading ? shimmerContent : content;
  }
}
