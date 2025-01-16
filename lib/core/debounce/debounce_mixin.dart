import 'dart:async';

mixin DebounceMixin {
  Timer? _debounceTimer;

  Future<void> debounceFunction(
    Future<void> Function() action, {
    required Duration duration,
  }) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    Completer<void> completer = Completer<void>();
    _debounceTimer = Timer(duration, () async {
      await action();
      completer.complete();
    });
    return completer.future;
  }

  void cancelDebounce() {
    _debounceTimer?.cancel();
  }
}
