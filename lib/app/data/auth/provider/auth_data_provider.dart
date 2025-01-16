import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/data/auth/source/remote/auth_remote_data_source.dart';
import 'package:flutter_clean_architechture/app/data/auth/source/remote/auth_remote_data_source_impl.dart';
import 'package:flutter_clean_architechture/app/domain/auth/repository/auth_repository.dart';
import 'package:flutter_clean_architechture/app/domain/auth/repository/auth_repository_impl.dart';
import 'package:flutter_clean_architechture/core/api/provider/api_provider.dart';

class AuthDataProvider {
  const AuthDataProvider._();

  // Repository Providers

  /// Provider for [AuthRepository].
  static final authRepositoryProvider = Provider<AuthRepository>((ref) {
    return AuthRepositoryImpl(
      authRemoteDataSource: ref.watch(authRemoteDataSourceProvider),
    );
  });

  // Remote Data Source Providers

  /// Provider for [AuthRemoteDataSource].
  static final authRemoteDataSourceProvider =
      Provider<AuthRemoteDataSource>((ref) {
    return AuthRemoteDataSourceImpl(
      httpService: ref.watch(ApiProvider.httpServiceProvider),
    );
  });
}
