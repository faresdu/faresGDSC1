import 'dart:async';

import 'package:gdsc_app/core/enums/tables.dart';
import 'package:gdsc_app/core/models/semester.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase/supabase.dart';

import '../app/app.locator.dart';

class SemesterService {
  final _supabaseService = locator<SupabaseService>();
  final BehaviorSubject<Semester> semesterSubject =
      BehaviorSubject.seeded(Semester.anonymous());

  Future<Semester> getCurrentSemester() async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.semesters)
          .select('*, ${GDSCTables.semesterBreaks}:semester_breaks(*)')
          .execute();
      if (res.hasError) {
        throw "Failed to get Semester, ERROR: ${res.error?.message}";
      }

      /// supabase gte lte doesn't work with dates for some reason so im doing it clientside
      print(res.data);
      final List<Semester> semesters = (res.data as List).map((s) {
        print(s);
        return Semester.fromJson(s);
      }).toList();

      final DateTime currentDate = DateTime.now();

      final Semester semester = semesters
          .where((s) =>
              s.startDate.isBefore(currentDate) &&
              s.endDate.isAfter(currentDate))
          .first;
      semesterSubject.add(semester);
      return semester;
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      rethrow;
    }
  }

  Future<int> getWeek(DateTime date) async {
    Semester semester = await semesterSubject.first;
    return DateHelper.getSemesterWeek(semester, date: date);
  }
}
