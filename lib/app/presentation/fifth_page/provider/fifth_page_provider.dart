import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/fifth_page/controller/fifth_page_controller.dart';

class FifthPageViewProvider {
  FifthPageViewProvider._();

  /// Provider for [FifthPageViewProvider].
  static final fifthPageViewControllerProvider =
      StateNotifierProvider<FifthPageViewController, FifthPageViewState>(
    (ref) {
      return FifthPageViewController();
    },
  );
}
