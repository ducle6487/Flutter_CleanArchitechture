import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/data/user/source/remote/user_remote_data_source.dart';
import 'package:Flutter_CleanArchitechture/app/data/user/source/remote/user_remote_data_source_impl.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/repository/user_repository.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/repository/user_repository_impl.dart';
import 'package:Flutter_CleanArchitechture/core/api/provider/api_provider.dart';

class UserDataProvider {
  const UserDataProvider._();

  // Repository Providers

  /// Provider for [UserRepository].
  static final userRepositoryProvider = Provider<UserRepository>((ref) {
    return UserRepositoryImpl(
      userRemoteDataSource: ref.watch(userRemoteDataSourceProvider),
    );
  });

  // Remote Data Source Providers

  /// Provider for [UserRemoteDataSource].
  static final userRemoteDataSourceProvider =
      Provider<UserRemoteDataSource>((ref) {
    return UserRemoteDataSourceImpl(
      httpService: ref.watch(ApiProvider.httpServiceProvider),
    );
  });
}
