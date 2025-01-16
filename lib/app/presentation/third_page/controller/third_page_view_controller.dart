import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThirdPageViewState {
  const ThirdPageViewState();

  /// Creates a copy of this class.
  ThirdPageViewState copyWith() {
    return const ThirdPageViewState();
  }
}

class ThirdPageViewController extends StateNotifier<ThirdPageViewState> {
  ThirdPageViewController()
      : super(
          const ThirdPageViewState(),
        );
}
