import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/models/social_media.dart';

class Member {
  final String id;
  final String sID;
  final String name;
  final String? major;
  final int hours;
  final String? photo;
  final Committee? committee;
  final List<SocialMedia>? socials;

  Member({
    required this.id,
    required this.sID,
    required this.name,
    this.major,
    required this.hours,
    this.photo,
    this.committee,
    this.socials,
  });

  factory Member.anonymous() {
    return Member(
      id: '',
      sID: '',
      name: '',
      major: '',
      hours: 0,
    );
  }

  factory Member.fromJson(Map<String, dynamic> map) {
    List<SocialMedia> socials = [];
    if (map["socials"] != null && (map["socials"] as List).first != null) {
      socials = (map["socials"] as List).map((e) {
        return SocialMedia.fromJson(e);
      }).toList();
    }
    return Member(
      id: map['user_id'] ?? '',
      sID: map['student_id'] ?? '',
      name: map['name'] ?? '',
      major: map['major'] ?? '',
      hours: map['hours'] ?? 0,
      photo: map['profile_picture'],
      committee: Committee.fromJson(map),
      socials: socials,
    );
  }
}
