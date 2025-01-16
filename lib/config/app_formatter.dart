import 'package:intl/intl.dart';

enum AppFormatter {
  dateTime("dd/MM/yyyy"),
  monthAndYear("MM/yyyy"),
  monthDayEn("MMMM dd"),
  monthDayVn("dd/MM"),
  fullMonth("MMMM"),
  month("MM"),
  day("dd"),
  daySt('st'),
  dayNd('nd'),
  dayRd('rd'),
  dayTh('th'),
  enUSTimeZone('en_US');

  final String format;

  const AppFormatter(this.format);

  // Method to get the format string
  DateFormat get formatter => DateFormat(format);
}
