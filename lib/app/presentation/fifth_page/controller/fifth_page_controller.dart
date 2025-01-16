import 'package:flutter_riverpod/flutter_riverpod.dart';

class FifthPageViewState {
  const FifthPageViewState();

  /// Creates a copy of this class.
  FifthPageViewState copyWith() {
    return const FifthPageViewState();
  }
}

class FifthPageViewController extends StateNotifier<FifthPageViewState> {
  FifthPageViewController()
      : super(
          const FifthPageViewState(),
        );
}
