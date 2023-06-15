import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/models/social_media.dart';

import 'committee.dart';

class GDSCUser extends Member {
  final String? email;

  GDSCUser({
    required String id,
    required String sID,
    required String name,
    String? major,
    required int hours,
    String? photo,
    Committee? committee,
    List<SocialMedia>? socials,
    this.email,
  }) : super(
          id: id,
          sID: sID,
          name: name,
          photo: photo,
          major: major,
          hours: hours,
          committee: committee,
          socials: socials,
        );

  factory GDSCUser.anonymous() {
    Member m = Member.anonymous();
    return GDSCUser(
      id: m.id,
      sID: m.sID,
      name: m.name,
      major: m.major,
      hours: m.hours,
      photo: m.photo,
      committee: m.committee,
      socials: m.socials,
    );
  }

  factory GDSCUser.fromJson(Map<String, dynamic> map) {
    Member m = Member.fromJson(map);
    return GDSCUser(
      id: m.id,
      sID: m.sID,
      name: m.name,
      major: m.major,
      hours: m.hours,
      photo: m.photo,
      committee: m.committee,
      socials: m.socials,
      email: map['email'],
    );
  }
}
