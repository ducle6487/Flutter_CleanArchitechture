import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/presentation/fifth_page/controller/fifth_page_controller.dart';

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
