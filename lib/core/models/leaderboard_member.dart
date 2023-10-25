import 'committee.dart';

class LeaderboardMember {
  final String id;
  final String name;
  final String profilePicture;
  final Committee? committee;
  final String? gender;
  final int hours;

  LeaderboardMember(
      {required this.profilePicture,
      required this.id,
      required this.name,
      this.committee,
      this.gender,
      required this.hours});

  factory LeaderboardMember.fromJson(Map<String, dynamic> map) {
    return LeaderboardMember(
        id: map['user_id'] ?? '',
        name: map['name'] ?? '',
        hours: map['hours'] ?? 0,
        profilePicture: map['profile_picture'] ?? '',
        committee: Committee.fromJson(map['Committees']),
        gender: map['gender']);
  }
}
