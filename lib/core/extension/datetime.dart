import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:intl/intl.dart';
import '../../config/app_formatter.dart';

extension DateTimeExtension on DateTime {
  String toMMYYYYorToday() {
    DateTime today = DateTime.now();

    // Check if the date is today
    if (year == today.year && month == today.month && day == today.day) {
      return 'Hiện tại';
    }

    // Format as MM/yyyy
    return '${month.toString().padLeft(2, '0')}/$year';
  }

  String timeAgo() {
    DateTime now = DateTime.now();
    Duration diff = now.difference(this);

    if (diff.inDays > 0) {
      if (diff.inDays == 1) {
        return LocalizationService.translateText(TextType.yesterday);
      }
      int days = diff.inDays;
      return '$days ${LocalizationService.translateText(TextType.daysAgo)}';
    } else if (diff.inHours > 0) {
      int hours = diff.inHours;
      return '$hours ${LocalizationService.translateText(TextType.hoursAgo)}';
    } else {
      if (diff.inMinutes == 0) {
        return LocalizationService.translateText(TextType.recent);
      }
      int minutes = diff.inMinutes;
      return '$minutes${LocalizationService.translateText(TextType.minutesAgo)}';
    }
  }

  String getOrdinalSuffix() {
    int day = this.day;

    if (day >= 11 && day <= 13) {
      return AppFormatter.dayTh.format;
    }

    switch (day % 10) {
      case 1:
        return AppFormatter.daySt.format;
      case 2:
        return AppFormatter.dayNd.format;
      case 3:
        return AppFormatter.dayRd.format;
      default:
        return AppFormatter.dayTh.format;
    }
  }

  String get currentHourAndMinute {
    String currentHourAndMinute = DateFormat('HH:mm').format(this);
    return currentHourAndMinute;
  }

  String get currentMonthAsString {
    String currentMonth = DateFormat('MM').format(this);
    return currentMonth;
  }

  String get currentDayAsString {
    String currentDay = DateFormat('dd').format(this);
    return currentDay;
  }
}

extension HourOnlyFormat on DateTime {
  String toHourOnlyString() {
    return '${hour.toString().padLeft(2, '0')}:00';
  }

  String get vietnameseDate {
    String date = DateFormat('dd/MM/yyyy').format(this);
    return date;
  }

  int get currentHour {
    String currentHour = DateFormat('HH').format(this);
    return int.parse(currentHour);
  }

  int get currentDay {
    String currentDay = DateFormat('dd').format(this);
    return int.parse(currentDay);
  }

  int get currentMonth {
    String currentMonth = DateFormat('MM').format(this);
    return int.parse(currentMonth);
  }

  String get currentFullMonth {
    String currentMonth = DateFormat('MMMM').format(this);
    return currentMonth;
  }

  bool isSameDayAsNow() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  String toMonthString() {
    switch (currentMonth) {
      case DateTime.january:
        return LocalizationService.translateText(TextType.january);
      case DateTime.february:
        return LocalizationService.translateText(TextType.february);
      case DateTime.march:
        return LocalizationService.translateText(TextType.march);
      case DateTime.april:
        return LocalizationService.translateText(TextType.april);
      case DateTime.may:
        return LocalizationService.translateText(TextType.may);
      case DateTime.june:
        return LocalizationService.translateText(TextType.june);
      case DateTime.july:
        return LocalizationService.translateText(TextType.july);
      case DateTime.august:
        return LocalizationService.translateText(TextType.august);
      case DateTime.september:
        return LocalizationService.translateText(TextType.september);
      case DateTime.october:
        return LocalizationService.translateText(TextType.october);
      case DateTime.november:
        return LocalizationService.translateText(TextType.november);
      case DateTime.december:
        return LocalizationService.translateText(TextType.december);
      default:
        return LocalizationService.translateText(TextType.june);
    }
  }
}
