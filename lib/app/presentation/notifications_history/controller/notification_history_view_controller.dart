import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/model/notification_history_group_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/model/notification_response_dto.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/usecase/clear_new_notification/clear_new_notification_usecase.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/usecase/get_notification_history/get_notification_history_usecase.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/usecase/get_unread_notifications_count/get_unread_notifications_count_usecase.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/usecase/loadmore_notification_history/loadmore_notification_history_usecase.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/usecase/mark_as_read_notification/mark_as_read_notification_usecase.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/core/animation/constants/animation_constants.dart';
import 'package:Flutter_CleanArchitechture/core/api/model/pagination.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';

class NotificationHistoryViewState {
  final List<NotificationResponseDTO> notificationsHistory;
  final PaginationDTO? pagination;
  final bool isLoading;
  final int unreadNotificationsCount;

  NotificationHistoryViewState({
    required this.notificationsHistory,
    required this.isLoading,
    this.pagination,
    required this.unreadNotificationsCount,
  });

  /// Creates a copy of this class.
  NotificationHistoryViewState copyWith({
    List<NotificationResponseDTO>? notificationsHistory,
    bool? isLoading,
    PaginationDTO? pagination,
    int? unreadNotificationsCount,
  }) {
    return NotificationHistoryViewState(
      notificationsHistory: notificationsHistory ?? this.notificationsHistory,
      isLoading: isLoading ?? this.isLoading,
      pagination: pagination ?? this.pagination,
      unreadNotificationsCount:
          unreadNotificationsCount ?? this.unreadNotificationsCount,
    );
  }
}

class NotificationHistoryViewController
    extends StateNotifier<NotificationHistoryViewState> {
  final GetNotificationHistoryUsecase _getNotificationHistoryUsecase;
  final LoadmoreNotificationHistoryUsecase _loadmoreNotificationHistoryUsecase;
  final MarkAsReadNotificationUsecase _markAsReadNotificationUsecase;
  final GetUnreadNotificationsCountUsecase _getUnreadNotificationsCountUsecase;
  final ClearNewNotificationUsecase _clearNewNotificationUsecase;

  NotificationHistoryViewController({
    required GetNotificationHistoryUsecase getNotificationHistoryUsecase,
    required LoadmoreNotificationHistoryUsecase
        loadmoreNotificationHistoryUsecase,
    required MarkAsReadNotificationUsecase markAsReadNotificationUsecase,
    required GetUnreadNotificationsCountUsecase
        getUnreadNotificationsCountUsecase,
    required ClearNewNotificationUsecase clearNewNotificationUsecase,
  })  : _getNotificationHistoryUsecase = getNotificationHistoryUsecase,
        _loadmoreNotificationHistoryUsecase =
            loadmoreNotificationHistoryUsecase,
        _markAsReadNotificationUsecase = markAsReadNotificationUsecase,
        _getUnreadNotificationsCountUsecase =
            getUnreadNotificationsCountUsecase,
        _clearNewNotificationUsecase = clearNewNotificationUsecase,
        super(
          NotificationHistoryViewState(
            notificationsHistory: [],
            isLoading: false,
            pagination: null,
            unreadNotificationsCount: 0,
          ),
        ) {
    getNotificationHistory();
    getUnreadNotificationsCount();
  }

  /// Getter for [notificationsHistory].
  List<NotificationResponseDTO> get notificationsHistory =>
      state.notificationsHistory;

  /// Getter for [notificationHistoryById]
  NotificationResponseDTO? notificationHistoryBy(String id) {
    return notificationsHistory.firstWhere(
      (noti) => noti.id.compareTo(id) == AppDimensions.zero,
    );
  }

  /// Getter for [pagination].
  PaginationDTO? get pagination => state.pagination;

  void getNotificationHistory() async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await _getNotificationHistoryUsecase.execute();
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          state = state.copyWith(
            notificationsHistory:
                response?.data as List<NotificationResponseDTO>,
            pagination: response?.pagination,
            isLoading: false,
          );
        },
      );
    } catch (error) {
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          state = state.copyWith(isLoading: false);
        },
      );
    }
  }

  void loadMoreNotificationHistory() async {
    try {
      final response = await _loadmoreNotificationHistoryUsecase.execute(
        page: state.pagination?.nextPage,
      );

      List<NotificationResponseDTO> noties =
          List.from(state.notificationsHistory);

      noties += response?.data as List<NotificationResponseDTO>? ?? [];
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {
          state = state.copyWith(
            notificationsHistory: noties,
            pagination: response?.pagination,
          );
        },
      );
    } catch (error) {
      Future.delayed(
        const Duration(
          milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS,
        ),
        () {},
      );
    }
  }

  void markAsReadNotification({
    required String notificationId,
  }) async {
    _updateNotificationIsSeen(notificationId: notificationId);
    try {
      await _markAsReadNotificationUsecase.execute(
        notificationId: notificationId,
      );
    } catch (_) {
      _updateNotificationIsSeen(notificationId: notificationId);
    } finally {
      getUnreadNotificationsCount();
    }
  }

  void clearNewNotification() async {
    state = state.copyWith(isLoading: true);
    try {
      await _clearNewNotificationUsecase.execute();
    } catch (_) {
    } finally {
      getNotificationHistory();
      getUnreadNotificationsCount();
    }
  }

  void getUnreadNotificationsCount() async {
    try {
      int response = await _getUnreadNotificationsCountUsecase.execute();
      state = state.copyWith(unreadNotificationsCount: response);
    } catch (_) {}
  }

  void _updateNotificationIsSeen({
    required String notificationId,
  }) {
    List<NotificationResponseDTO> copyList =
        List.from(state.notificationsHistory);

    NotificationResponseDTO filterdNoti = state.notificationsHistory.firstWhere(
      (noti) => noti.id.compareTo(notificationId) == AppDimensions.zero,
    );

    NotificationResponseDTO newNoti = NotificationResponseDTO(
      id: filterdNoti.id,
      title: filterdNoti.title,
      description: filterdNoti.description,
      isSeen: true,
      accessId: filterdNoti.accessId,
      notificationTypeCode: filterdNoti.notificationTypeCode,
      createdAt: filterdNoti.createdAt,
    );

    copyList[copyList.indexWhere((element) =>
        element.id.compareTo(notificationId) == AppDimensions.zero)] = newNoti;

    state = state.copyWith(notificationsHistory: copyList);
  }

  List<NotificationHistoryGroupDTO> getNotificationsHistoryGrouped() {
    // Convert JSON data to NotificationResponseDTO objects
    List<NotificationResponseDTO> notifications = state.notificationsHistory;

    // Get today's date and yesterday's date
    DateTime today = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));

    // Group notifications by createdAt date
    Map<String, List<NotificationResponseDTO>> groupedByCreatedAt = {};
    for (var notification in notifications) {
      String createdAtKey;
      if (notification.createdAt?.year == today.year &&
          notification.createdAt?.month == today.month &&
          notification.createdAt?.day == today.day) {
        createdAtKey = LocalizationService.translateText(TextType.today);
      } else if (notification.createdAt?.year == yesterday.year &&
          notification.createdAt?.month == yesterday.month &&
          notification.createdAt?.day == yesterday.day) {
        createdAtKey = LocalizationService.translateText(TextType.yesterday);
      } else {
        createdAtKey =
            '${notification.createdAt?.day}/${notification.createdAt?.month}/${notification.createdAt?.year}';
      }

      if (!groupedByCreatedAt.containsKey(createdAtKey)) {
        groupedByCreatedAt[createdAtKey] = [];
      }
      groupedByCreatedAt[createdAtKey]!.add(notification);
    }

    // Create NotificationHistoryGroupDTO instances
    List<NotificationHistoryGroupDTO> groupedNotifications =
        groupedByCreatedAt.entries.map((entry) {
      // Use the createdAt date as the title
      return NotificationHistoryGroupDTO(
        title: entry.key,
        notifications: entry.value,
      );
    }).toList();

    return groupedNotifications;
  }
}
