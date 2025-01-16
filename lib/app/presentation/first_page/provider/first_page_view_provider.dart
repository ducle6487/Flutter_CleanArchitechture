import 'package:flutter_clean_architechture/app/presentation/first_page/controller/first_page_view_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstPageViewProvider {
  const FirstPageViewProvider._();

  /// Provider for [FirstPageViewController].
  static final firstPageViewControllerProvider =
      StateNotifierProvider<FirstPageViewController, FirstPageViewState>(
    (ref) {
      return FirstPageViewController();
    },
  );
}
