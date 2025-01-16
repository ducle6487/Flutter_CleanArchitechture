import 'package:Flutter_CleanArchitechture/app/data/notification/source/remote/notification_remote_data_source.dart';
import 'package:Flutter_CleanArchitechture/app/data/notification/source/remote/notification_remote_data_source_impl.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/repository/notification_repository.dart';
import 'package:Flutter_CleanArchitechture/app/domain/notification/repository/notification_repository_impl.dart';
import 'package:Flutter_CleanArchitechture/core/api/provider/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationDataProvider {
  const NotificationDataProvider._();

  // Repository Providers

  /// Provider for [NotificationRepository].
  static final notificationRepositoryProvider =
      Provider<NotificationRepository>((ref) {
    return NotificationRepositoryImpl(
      notificationRemoteDataSource:
          ref.watch(notificationRemoteDataSourceProvider),
    );
  });

  // Remote Data Source Providers

  /// Provider for [NotificationRemoteDataSource].
  static final notificationRemoteDataSourceProvider =
      Provider<NotificationRemoteDataSource>((ref) {
    return NotificationRemoteDataSourceImpl(
      httpService: ref.watch(ApiProvider.httpServiceProvider),
    );
  });
}
