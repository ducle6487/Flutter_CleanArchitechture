import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/data/notification/provider/notification_data_provider.dart';
import 'package:flutter_clean_architechture/app/domain/notification/usecase/clear_new_notification/clear_new_notification_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/notification/usecase/clear_new_notification/clear_new_notification_usecase_impl.dart';
import 'package:flutter_clean_architechture/app/domain/notification/usecase/get_notification_history/get_notification_history_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/notification/usecase/get_notification_history/get_notification_history_usecase_impl.dart';
import 'package:flutter_clean_architechture/app/domain/notification/usecase/get_unread_notifications_count/get_unread_notifications_count_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/notification/usecase/get_unread_notifications_count/get_unread_notifications_count_usecase_impl.dart';
import 'package:flutter_clean_architechture/app/domain/notification/usecase/loadmore_notification_history/loadmore_notification_history_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/notification/usecase/loadmore_notification_history/loadmore_notification_history_usecase_impl.dart';
import 'package:flutter_clean_architechture/app/domain/notification/usecase/mark_as_read_notification/mark_as_read_notification_usecase.dart';
import 'package:flutter_clean_architechture/app/domain/notification/usecase/mark_as_read_notification/mark_as_read_notification_usecase_impl.dart';

class NotificationDomainProvider {
  const NotificationDomainProvider._();

  /// Provider for [GetNotificationHistoryUseCase].
  static final getNotificationHistoryUsecaseProvider =
      Provider<GetNotificationHistoryUsecase>(
    (ref) {
      return GetNotificationHistoryUsecaseImpl(
        notificationRepository: ref.watch(
          NotificationDataProvider.notificationRepositoryProvider,
        ),
      );
    },
  );

  /// Provider for [LoadmoreNotificationHistoryUseCase].
  static final loadmoreNotificationHistoryUsecaseProvider =
      Provider<LoadmoreNotificationHistoryUsecase>(
    (ref) {
      return LoadmoreNotificationHistoryUsecaseImpl(
        notificationRepository: ref.watch(
          NotificationDataProvider.notificationRepositoryProvider,
        ),
      );
    },
  );

  /// Provider for [MarkAsReadNotificationUseCase].
  static final markAsReadNotificationUsecaseProvider =
      Provider<MarkAsReadNotificationUsecase>(
    (ref) {
      return MarkAsReadNotificationUsecaseImpl(
        notificationRepository: ref.watch(
          NotificationDataProvider.notificationRepositoryProvider,
        ),
      );
    },
  );

  /// Provider for [GetUnreadNotificationsCount].
  static final getUnreadNotificationsCountUsecaseProvider =
      Provider<GetUnreadNotificationsCountUsecase>(
    (ref) {
      return GetUnreadNotificationsCountUsecaseImpl(
        notificationRepository: ref.watch(
          NotificationDataProvider.notificationRepositoryProvider,
        ),
      );
    },
  );

  /// Provider for [ClearNewNotification].
  static final clearNewNotificationUsecaseProvider =
      Provider<ClearNewNotificationUsecase>(
    (ref) {
      return ClearNewNotificationUsecaseImpl(
        notificationRepository: ref.watch(
          NotificationDataProvider.notificationRepositoryProvider,
        ),
      );
    },
  );
}
