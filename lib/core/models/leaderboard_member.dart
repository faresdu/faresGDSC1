import 'committee.dart';

class LeaderboardMember {
  final String id;
  final String name;
  final Committee? committee;
  final int hours;

  LeaderboardMember(
      {required this.id,
      required this.name,
      this.committee,
      required this.hours});

  factory LeaderboardMember.fromJson(Map<String, dynamic> map) {
    return LeaderboardMember(
        id: map['user_id'] ?? '',
        name: map['name'] ?? '',
        hours: map['hours'] ?? 0,
        committee: Committee.anonymous());
  }
}
