import 'package:gdsc_app/core/models/semester_break.dart';

class Semester {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final List<SemesterBreak> semesterBreaks;

  Semester(
      {required this.id,
      required this.startDate,
      required this.endDate,
      required this.semesterBreaks});

  factory Semester.anonymous() {
    return Semester(
        id: '',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        semesterBreaks: []);
  }

  factory Semester.fromJson(Map<String, dynamic> map) {
    List<SemesterBreak> semBreaks = [];
    if (map["semester_breaks"] != null &&
        (map['semester_breaks'] as List).first != null &&
        (map['semester_breaks'] as List).first['semester_id'] != null) {
      semBreaks = (map["semester_breaks"] as List).map((e) {
        return SemesterBreak.fromJson(e);
      }).toList();
    }
    return Semester(
        id: map['id'],
        startDate: DateTime.parse(map['start_date']),
        endDate: DateTime.parse(map['end_date']),
        semesterBreaks: semBreaks);
  }
}
