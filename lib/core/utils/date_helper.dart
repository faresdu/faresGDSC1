import 'package:flutter/material.dart';

class DateHelper {
  static final Map<int, String> day = {
    1: 'الإثنين',
    2: 'الثلاثاء',
    3: 'الأربعاء',
    4: 'الخمبس',
    5: 'الجمعة',
    6: 'السبت',
    7: 'الأحد',
  };

  static final Map<int, String> month = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };

  static String getWeekDay(DateTime d) {
    return day[d.weekday]!;
  }

  static String getDate(DateTime d, {bool dash = false}) {
    if (dash) {
      return '${d.year}-${d.day}-${d.month}';
    }
    return '${d.year}/${d.month}/${d.day}';
  }

  static String getMonth(DateTime d) {
    return month[d.month]!;
  }

  static String getHour(DateTime d) {
    return getHourTOD(TimeOfDay.fromDateTime(d));
  }

  static String getHourTOD(TimeOfDay d) {
    int hour = d.hour;
    int minutes = d.minute;
    String x;
    if (hour >= 12) {
      x = "PM";
      if (hour != 12) {
        hour -= 12;
      }
    } else {
      x = 'AM';
      if (hour == 0) {
        hour = 12;
      }
    }
    String sMinutes;
    if (minutes.toString().length == 1) {
      sMinutes = '0$minutes';
    } else {
      sMinutes = '$minutes';
    }
    return '$hour:$sMinutes$x';
  }

  static DateTimeAndTimeOfDay(DateTime dateTime, TimeOfDay timeOfDay) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, timeOfDay.hour, timeOfDay.minute);
  }
}
