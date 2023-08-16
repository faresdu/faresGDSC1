import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/models/post.dart';
import 'package:gdsc_app/core/models/user_social_media.dart';
import 'package:gdsc_app/core/models/volunteer_hours.dart';

class Member {
  final String id;
  final String sID;
  final String name;
  final String? email;
  final String? phoneNumber;
  final String? major;
  final String? photo;
  final Committee committee;
  final List<UserSocialMedia> socials;
  final List<Event> events;
  final List<Post> posts;
  final List<VolunteerHours> volunteerHours;
  final int hours;

  Member({
    required this.id,
    required this.sID,
    required this.name,
    this.email,
    this.phoneNumber,
    this.major,
    this.photo,
    required this.committee,
    required this.socials,
    required this.events,
    required this.posts,
    required this.volunteerHours,
    required this.hours,
  });

  factory Member.anonymous() {
    return Member(
      id: '',
      sID: '',
      name: '',
      major: '',
      socials: [],
      events: [],
      posts: [],
      committee: Committee.anonymous(),
      volunteerHours: [],
      hours: 0,
    );
  }

  bool isLeader() => id == committee.leaderID;

  bool isCoLeader() => id == committee.coLeaderID;

  bool isLeaderOrCoLeader() => isLeader() || isCoLeader();

  String getRole() {
    if (isLeader()) {
      return "قائد";
    } else if (isCoLeader()) {
      return "نائب قائد";
    }
    return 'عضو';
  }

  static int getHours(List<VolunteerHours> volunteerHours) {
    int i = 0;
    for (VolunteerHours v in volunteerHours) {
      if (v.isApproved != null && v.isApproved!) {
        i += v.hours;
      }
    }
    return i;
  }

  List<VolunteerHours> getApprovedVolunteerHours() =>
      volunteerHours.where((e) => e.isAccepted()).toList();

  List<VolunteerHours> getPendingVolunteerHours() =>
      volunteerHours.where((e) => e.isPending()).toList();

  List<VolunteerHours> getRejectedVolunteerHours() =>
      volunteerHours.where((e) => e.isRejected()).toList();

  factory Member.fromJson(Map<String, dynamic> map) {
    try {
      List<UserSocialMedia> socials = [];
      if (map["socials"] != null &&
          (map['socials'] as List).first != null &&
          (map['socials'] as List).first['social_id'] != null) {
        socials = (map["socials"] as List).map((e) {
          return UserSocialMedia.fromJson(e);
        }).toList();
      }
      List<Event> events = [];
      if (map["created_events"] != null &&
          (map['created_events'] as List).first != null &&
          (map['created_events'] as List).first['event_id'] != null) {
        events = (map["created_events"] as List).map((e) {
          return Event.fromJson(e);
        }).toList();
      }
      List<Post> posts = [];
      if (map["posts"] != null &&
          (map['posts'] as List).first != null &&
          (map['posts'] as List).first['id'] != null) {
        posts = (map["posts"] as List).map((e) {
          e['Committees'] = e['Committees'] ?? map['committee'];
          return Post.fromJson(e);
        }).toList();
        posts.sort((a, b) =>
            b.createdAt.microsecondsSinceEpoch -
            a.createdAt.microsecondsSinceEpoch);
      }
      List<VolunteerHours> volunteers = [];
      if (map["volunteers"] != null &&
          (map['volunteers'] as List).first != null &&
          (map['volunteers'] as List).first['volunteer_id'] != null) {
        volunteers = (map["volunteers"] as List).map((e) {
          return VolunteerHours.fromJson(e);
        }).toList();
        volunteers.sort((a, b) =>
            b.createdAt.microsecondsSinceEpoch -
            a.createdAt.microsecondsSinceEpoch);
      }
      return Member(
        id: map['user_id'] ?? '',
        sID: map['student_id'] ?? '',
        name: map['name'],
        email: map['email'],
        phoneNumber: map['phone_number'] ?? '',
        major: map['major'] ?? '',
        photo: map['profile_picture'],
        committee: map['committee'] != null
            ? Committee.fromJson(map['committee'])
            : Committee.anonymous(),
        events: events,
        posts: posts,
        socials: socials,
        volunteerHours: volunteers,
        hours: getHours(volunteers),
      );
    } catch (e) {
      throw 'Failed to make User, ERROR : $e';
    }
  }
}
