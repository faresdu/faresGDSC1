class SemesterBreak {
  final String id;
  final String semesterId;
  final DateTime breakStartDate;
  final DateTime breakEndDate;

  SemesterBreak(
      {required this.id,
      required this.semesterId,
      required this.breakStartDate,
      required this.breakEndDate});

  factory SemesterBreak.fromJson(Map<String, dynamic> map) {
    return SemesterBreak(
        id: map['id'],
        semesterId: map['semester_id'],
        breakStartDate: DateTime.parse(map['break_start_date']),
        breakEndDate: DateTime.parse(map['break_end_date']));
  }
}
