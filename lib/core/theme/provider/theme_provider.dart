import 'package:flutter_clean_architechture/core/theme/controller/theme_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeProvider {
  const ThemeProvider._();

  /// Provider for [ThemeController].
  static final themeControllerProvider =
      StateNotifierProvider<ThemeController, ThemeState>((ref) {
    return ThemeController();
  });
}
