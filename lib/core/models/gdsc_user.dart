import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/models/post.dart';
import 'package:gdsc_app/core/models/user_social_media.dart';
import 'package:gdsc_app/core/models/volunteer_hours.dart';

import 'committee.dart';
import 'event.dart';

class GDSCUser extends Member {
  GDSCUser(
      {required String id,
      required String sID,
      required String name,
      String? major,
      String? photo,
      required Committee committee,
      required List<UserSocialMedia> socials,
      required List<Event> events,
      required List<Post> posts,
      required List<VolunteerHours> volunteers,
      required int hours,
      String? email,
      String? phoneNumber,
      bool isAdmin = false})
      : super(
            id: id,
            sID: sID,
            name: name,
            email: email,
            phoneNumber: phoneNumber,
            photo: photo,
            major: major,
            committee: committee,
            socials: socials,
            events: events,
            posts: posts,
            volunteerHours: volunteers,
            hours: hours,
            isAdmin: isAdmin);

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
        events: m.events,
        posts: m.posts,
        volunteers: m.volunteerHours,
        hours: m.hours,
        email: m.email,
        phoneNumber: m.phoneNumber,
        isAdmin: m.isAdmin);
  }
}
