import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:gdsc_app/core/utils/string_extensions.dart';

class HourRequest {
  final String id;
  final String committeeId;
  final String userId;
  final String? userAvatar;
  final String userName;
  final int hours;
  final int createdAtMillis;
  final String reasoning;
  bool? approved;
  final String? createdAt;

  HourRequest(
      {required this.id,
      required this.committeeId,
      required this.userId,
      required this.userName,
      required this.hours,
      required this.reasoning,
      required this.createdAtMillis,
      this.userAvatar,
      this.approved,
      this.createdAt});

  factory HourRequest.anonymous() {
    return HourRequest(
      id: '',
      committeeId: '',
      userId: '',
      userName: '',
      hours: 0,
      reasoning: '',
      createdAtMillis: DateTime.utc(1900).millisecondsSinceEpoch,
    );
  }
  static String _getDate(DateTime date) {
    return "${DateHelper.getWeekDay(date)} , ${DateHelper.getDate(date, dash: true)}";
  }

  factory HourRequest.fromJson(Map<String, dynamic> map) {
    return HourRequest(
      id: map['volunteer_id'],
      committeeId: map['committee_id'],
      userId: map['user_id'],
      userName: map['Users']['name'],
      userAvatar: map['Users']['profile_picture'],
      hours: map['hours'].toString().parseInt,
      reasoning: map['reasoning'] ?? 'السبب لم يذكر',
      approved: map['approved'],
      createdAtMillis:
          DateTime.tryParse(map['created_at'])?.millisecondsSinceEpoch ??
              DateTime.utc(1900).millisecondsSinceEpoch,
      createdAt:
          _getDate(DateTime.tryParse(map['created_at']) ?? DateTime.utc(1900)),
    );
  }
}
