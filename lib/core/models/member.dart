import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/models/social_media.dart';
import 'package:gdsc_app/core/models/volunteer_hours.dart';

class Member {
  final String id;
  final String sID;
  final String name;
  final String major;
  final int hours;
  final String? photo;
  final Committee committee;
  final List<SocialMedia> socials;
  final List<Event> events;
  final List<VolunteerHours> volunteerHours;

  Member({
    required this.id,
    required this.sID,
    required this.name,
    required this.major,
    required this.hours,
    this.photo,
    required this.committee,
    required this.socials,
    required this.events,
    required this.volunteerHours,
  });

  factory Member.anonymous() {
    return Member(
      id: '',
      sID: '',
      name: '',
      major: '',
      hours: 0,
      socials: [],
      events: [],
      committee: Committee.anonymous(),
      volunteerHours: [],
    );
  }

  factory Member.fromJson(Map<String, dynamic> map) {
    List<SocialMedia> socials = [];
    if (map["socials"] != null &&
        (map['socials'] as List).first != null &&
        (map['socials'] as List).first['social_id'] != null) {
      socials = (map["socials"] as List).map((e) {
        return SocialMedia.fromJson(e);
      }).toList();
    }
    List<Event> events = [];
    if (map["events"] != null &&
        (map['events'] as List).first != null &&
        (map['events'] as List).first['event_id'] != null) {
      events = (map["events"] as List).map((e) {
        return Event.fromJson(e);
      }).toList();
    }
    List<VolunteerHours> volunteers = [];
    if (map["volunteers"] != null &&
        (map['volunteers'] as List).first != null &&
        (map['volunteers'] as List).first['volunteer_id'] != null) {
      volunteers = (map["volunteers"] as List).map((e) {
        return VolunteerHours.fromJson(e);
      }).toList();
    }
    return Member(
      id: map['user_id'] ?? '',
      sID: map['student_id'] ?? '',
      name: map['name'] ?? '',
      major: map['major'] ?? '',
      hours: map['hours'] ?? 0,
      photo: map['profile_picture'],
      committee: map['committee'] != null
          ? Committee.fromJson(map['committee'])
          : Committee.anonymous(),
      events: events,
      socials: socials,
      volunteerHours: volunteers,
    );
  }
}
