import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/models/social_media.dart';

class Member {
  final String id;
  final String sID;
  final String name;
  final String? photo;
  final String? major;
  final Committee? committee;
  final List<SocialMedia>? socials;
  final int? hours;

  @override
  String toString() {
    return id;
  }

  Member({
    required this.id,
    required this.sID,
    required this.name,
    this.major,
    this.photo,
    this.committee,
    this.socials,
    this.hours,
  });

  factory Member.anonymous() {
    return Member(
      id: '',
      sID: '',
      name: '',
      major: '',
      committee: Committee.anonymous(),
      socials: [],
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
      sID: map['student_id'].toString() ?? '',
      name: map['name'] ?? '',
      major: map['major'] ?? '',
      photo: map['profile_picture'],
      committee: Committee.fromJson(map),
      socials: socials,
      hours: map['hours'] ?? 0,
    );
  }
}
