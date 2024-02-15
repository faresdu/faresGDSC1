import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/semester.dart';
import 'package:gdsc_app/core/models/semester_break.dart';

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

  static String sincePosted(DateTime date) {
    DateTime parsedDate = DateTime.parse("$date");
    Duration dur = DateTime.now().difference(parsedDate);
    if (dur.inDays > 0) {
      if (dur.inDays == 1) {
        return 'يوم';
      } else if (dur.inDays == 2) {
        return 'يومين';
      } else if (dur.inDays <= 10) {
        return '${dur.inDays} ايام';
      } else {
        return '${dur.inDays} يوم';
      }
    } else if (dur.inHours > 0) {
      return '${dur.inHours} ساعة';
    } else if (dur.inMinutes > 0) {
      return '${dur.inMinutes} دقيقة';
    } else {
      return '${dur.inSeconds} ثانية';
    }
  }

  static int daysSinceDate(DateTime date) {
    Duration dur = DateTime.now().difference(date);
    return dur.inDays;
  }

  static DateTime dateTimeAndTimeOfDay(DateTime dateTime, TimeOfDay timeOfDay) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, timeOfDay.hour,
        timeOfDay.minute);
  }

  static int getSemesterWeek(Semester semester, {DateTime? date}) {
    final currentDate = date ?? DateTime.now();
    // Find the number of Sundays since the start of the semester
    final startDateSunday = semester.startDate.weekday == DateTime.sunday
        ? semester.startDate
        : semester.startDate.add(
            Duration(days: DateTime.sunday - semester.startDate.weekday + 7));
    final sundaysPassed = currentDate.difference(startDateSunday).inDays ~/ 7;

    return sundaysPassed + 1;
  }

  /// UNTESTED: needs modification
  static int getSemesterWeekWithBreaks(Semester semester, {DateTime? date}) {
    final currentDate = date ?? DateTime.now();

    Duration breakDuration = const Duration();
    List<SemesterBreak> relevantBreaks = semester.semesterBreaks
        .where((b) =>
            b.breakStartDate.millisecondsSinceEpoch <
                currentDate.millisecondsSinceEpoch &&
            b.breakEndDate.day - b.breakStartDate.day >= 4)
        .toList();
    for (final breakPeriod in relevantBreaks) {
      final breakStartDate = breakPeriod.breakStartDate;
      final breakEndDate = breakPeriod.breakEndDate;
      final duration = breakEndDate.difference(breakStartDate);
      breakDuration += duration + const Duration(days: 1);
    }

    final totalDays = currentDate.difference(semester.startDate).inDays;
    final adjustedDays = totalDays - breakDuration.inDays;

    // Find the first Sunday on or after the start of the semester
    final startDateSunday = semester.startDate.weekday == DateTime.sunday
        ? semester.startDate
        : semester.startDate.add(
            Duration(days: DateTime.sunday - semester.startDate.weekday + 7));

    // Calculate the number of Sundays that have passed since startDateSunday
    int sundaysPassed = 0;
    for (int i = 0; i <= adjustedDays; i++) {
      final currentDay = startDateSunday.add(Duration(days: i));
      if (currentDay.weekday == DateTime.sunday &&
          !relevantBreaks.any((b) =>
              currentDay.isAfter(b.breakStartDate) &&
              currentDay.isBefore(b.breakEndDate))) {
        sundaysPassed++;
      }
    }

    return sundaysPassed + 1;
  }

  static String postDateText(DateTime dateTime) {
    return DateHelper.daysSinceDate(dateTime) >= 30
        ? DateHelper.getDate(dateTime)
        : DateHelper.sincePosted(dateTime);
  }
}
