import 'package:flutter_clean_architechture/core/storage/service/shared_preference_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StorageProvider {
  const StorageProvider._();

  /// Provider for [SharedPreferenceService].
  static final sharedPreferenceServiceProvider =
      Provider<SharedPreferenceService>((ref) {
    throw UnimplementedError();
  });
}
