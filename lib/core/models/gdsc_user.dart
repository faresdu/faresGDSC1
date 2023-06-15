import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/models/social_media.dart';
import 'package:gdsc_app/core/models/volunteer_hours.dart';

import 'committee.dart';
import 'event.dart';

class GDSCUser extends Member {
  final String? email;

  GDSCUser({
    required String id,
    required String sID,
    required String name,
    String? major,
    required int hours,
    String? photo,
    required Committee committee,
    required List<SocialMedia> socials,
    required List<Event> events,
    required List<VolunteerHours> volunteers,
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
          events: events,
          volunteerHours: volunteers,
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
      events: m.events,
      volunteers: m.volunteerHours,
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
      events: m.events,
      volunteers: m.volunteerHours,
      email: map['email'],
    );
  }
}
