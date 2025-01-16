import 'package:flutter_riverpod/flutter_riverpod.dart';

class LaunchViewState {
  const LaunchViewState();
}

class LaunchViewController extends StateNotifier<LaunchViewState> {
  LaunchViewController()
      : super(
          const LaunchViewState(),
        );
}
