// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget GestureDetectorWithSound({
  required Widget child,
  required Function() onTap,
}) {
  return GestureDetector(
    onTap: () {
      SystemSound.play(SystemSoundType.click);
      onTap();
    },
    child: child,
  );
}

Widget GestureDetectorWithVibration({
  required Widget child,
  required Function() onTap,
}) {
  return GestureDetector(
    onTap: () {
      HapticFeedback.mediumImpact();
      onTap();
    },
    child: child,
  );
}
