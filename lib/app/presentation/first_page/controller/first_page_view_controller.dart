import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstPageViewState {
  const FirstPageViewState();

  /// Creates a copy of this class.
  FirstPageViewState copyWith() {
    return const FirstPageViewState();
  }
}

class FirstPageViewController extends StateNotifier<FirstPageViewState> {
  FirstPageViewController()
      : super(
          const FirstPageViewState(),
        );
}
