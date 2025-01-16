extension DoubleExtension on double {
  double toFixedOneDecimal() {
    return double.parse(toStringAsFixed(1));
  }

  String toCleanString() {
    return this % 1 == 0 ? toStringAsFixed(0) : toString();
  }

  String toHeightString() {
    int meters = (this ~/ 100); // Integer division
    int centimeters =
        (toInt() % 100); // Get the remainder after division by 100
    return '${meters}m${centimeters.toString().padLeft(2, '0')}';
  }
}
