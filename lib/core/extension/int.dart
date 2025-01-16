extension TimeFormat on int {
  String toTimeString() {
    String formattedNumber = toString().padLeft(2, '0');
    return '$formattedNumber:00';
  }

  String toTwoDigitString() {
    return toString().padLeft(2, '0');
  }
}
