import 'package:gdsc_app/core/models/committee.dart';

import 'member.dart';

class VolunteerHours {
  final String volunteerID;
  final String userID;
  final String committeeID;
  final String? reasoning;
  final int hours;
  final bool? isApproved;

  VolunteerHours({
    required this.volunteerID,
    required this.userID,
    required this.committeeID,
    this.reasoning,
    required this.hours,
    this.isApproved,
  });

  factory VolunteerHours.anonymous() {
    Committee c = Committee.anonymous();
    Member m = Member.anonymous();
    return VolunteerHours(
      volunteerID: '',
      userID: m.id,
      committeeID: c.id,
      hours: 0,
    );
  }

  bool isPending() {
    return isApproved == null;
  }

  bool isAccepted() {
    return !isPending() && isApproved == true;
  }

  bool isRejected() {
    return !isPending() && isApproved == false;
  }

  factory VolunteerHours.fromJson(Map<String, dynamic> map) {
    VolunteerHours v = VolunteerHours.anonymous();
    return VolunteerHours(
      volunteerID: map['volunteer_id'] ?? v.volunteerID,
      userID: map['user_id'] ?? v.userID,
      committeeID: map['committee_id'] ?? v.committeeID,
      reasoning: map['reasoning'],
      hours: map['hours'] ?? v.hours,
      isApproved: map['approved'],
    );
  }
}
