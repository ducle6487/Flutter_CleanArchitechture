import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/presentation/launch/controller/launch_view_controller.dart';

class LaunchViewProvider {
  const LaunchViewProvider._();

  /// Provider for [launchViewControllerProvider].
  static final launchViewControllerProvider =
      StateNotifierProvider<LaunchViewController, LaunchViewState>(
    (ref) {
      return LaunchViewController();
    },
  );
}
