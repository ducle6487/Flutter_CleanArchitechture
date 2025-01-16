import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/third_page/controller/third_page_view_controller.dart';

class ThirdPageViewProvider {
  const ThirdPageViewProvider._();

  /// Provider for [ThirdPageViewProvider].
  static final thirdPageViewControllerProvider =
      StateNotifierProvider<ThirdPageViewController, ThirdPageViewState>(
    (ref) {
      return ThirdPageViewController();
    },
  );
}
