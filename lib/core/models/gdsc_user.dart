import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/models/volunteer_hours.dart';


class GDSCUser extends Member {
  GDSCUser(
      {required super.id,
      required super.sID,
      required super.name,
      super.major,
      super.photo,
      super.role,
      required super.committee,
      required super.socials,
      required super.events,
      required super.posts,
      required List<VolunteerHours> volunteers,
      required super.hours,
      super.gender,
      super.email,
      super.phoneNumber,
      super.isAdmin})
      : super(
            volunteerHours: volunteers);

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
        events: m.events,
        posts: m.posts,
        volunteers: m.volunteerHours,
        hours: m.hours,
        gender: m.gender,
        role: m.role);
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
        events: m.events,
        posts: m.posts,
        volunteers: m.volunteerHours,
        hours: m.hours,
        email: m.email,
        phoneNumber: m.phoneNumber,
        isAdmin: m.isAdmin,
        gender: m.gender,
        role: m.role);
  }
}
