import 'package:flutter/material.dart';

extension StringFormat on String {
  DateTime toDateTime() {
    return DateTime.parse(this);
  }

  int toIntValue() {
    return int.parse(this);
  }

  int toHourByHHMValue() {
    return int.parse(this) ~/ 100;
  }

  double? toDouble() {
    return double.tryParse(this);
  }

  // Convert a hex color string to a Color
  Color toColor() {
    String colorString = this;

    // Check if the string starts with "#" and remove it if necessary
    if (colorString.startsWith('#')) {
      colorString = colorString.substring(1);
    }

    // Convert the string into an integer and return as Color
    return Color(int.parse('0xFF$colorString'));
  }
}
