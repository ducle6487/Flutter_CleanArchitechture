import 'package:Flutter_CleanArchitechture/core/localization/controller/localization_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalizationProvider {
  const LocalizationProvider._();

  /// Provider for [LocalizationController].
  static final localizationControllerProvider =
      StateNotifierProvider<LocalizationController, LocalizationState>((ref) {
    return LocalizationController();
  });
}
