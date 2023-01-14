import 'package:gdsc_app/core/models/committee.dart';

class Member {
  final String id;
  final String sID;
  final String name;
  final String? photo;
  final Committee? committee;
  // final SocialMedia[] socials;

  Member(
      {required this.id,
      required this.sID,
      required this.name,
      this.photo,
      this.committee});

  factory Member.anonymous() {
    return Member(id: '', sID: '', name: '', committee: Committee.anonymous()
        // socials:[]
        );
  }
  factory Member.fromJson(Map<String, dynamic> map) {
    return Member(
        id: map['user_id'] ?? '',
        sID: map['student_id'].toString() ?? '',
        name: map['name'] ?? '',
        photo: map['profile_picture'] ?? '',
        committee: Committee.fromJson(map));
  }
}
