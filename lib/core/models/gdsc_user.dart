import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/models/social_media.dart';

import 'committee.dart';

class GDSCUser extends Member {
  final String? email;

  GDSCUser({
    required String id,
    required String sID,
    required String name,
    String? photo,
    String? major,
    Committee? committee,
    List<SocialMedia>? socials,
    int? hours,
    this.email,
  }) : super(
          id: id,
          sID: sID,
          name: name,
          photo: photo,
          major: major,
          committee: committee,
          socials: socials,
          hours: hours,
        );

  factory GDSCUser.anonymous() {
    Member m = Member.anonymous();
    return GDSCUser(
      id: m.id,
      sID: m.sID,
      name: m.name,
      major: m.major,
      photo: m.photo,
      committee: m.committee,
      socials: m.socials,
      hours: m.hours,
    );
  }

  factory GDSCUser.fromJson(Map<String, dynamic> map) {
    Member m = Member.fromJson(map);
    return GDSCUser(
      id: m.id,
      sID: m.sID,
      name: m.name,
      major: m.major,
      photo: m.photo,
      committee: m.committee,
      socials: m.socials,
      hours: m.hours,
      email: map['email'],
    );
  }
}
