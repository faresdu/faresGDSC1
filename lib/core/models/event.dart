import 'member.dart';

class Event {
  final String eventID;
  final String instructorID;
  final String instructor;
  final String title;
  final String? flyer;
  final String? description;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final List<Member> attendees;
  final int numAttendees;
  final int maxAttendees;

  Event({
    required this.eventID,
    required this.instructorID,
    required this.title,
    required this.flyer,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.attendees,
    required this.numAttendees,
    required this.maxAttendees,
    required this.instructor,
  });

  factory Event.fromJson(Map<String, dynamic> map) {
    List<Member> members = [];
    if (map["attendees"] != null && (map["attendees"] as List).first != null) {
      members = (map["attendees"] as List).map((e) {
        return Member.fromJson(e);
      }).toList();
    }
    return Event(
      eventID: map['event_id'] ?? '',
      instructorID: map['instructor_id'] ?? '',
      instructor: map['name'] ?? '',
      title: map['title'] ?? '',
      flyer: map['flyer'],
      description: map['description'],
      date: DateTime.tryParse(map['start_date']) ?? DateTime.utc(1900),
      startTime: DateTime.tryParse('${map['start_date']} ${map['start_time']}') ?? DateTime.utc(1900),
      endTime: DateTime.tryParse('${map['start_date']} ${map['end_time']}') ?? DateTime.utc(1900),
      location: map['place'] ?? '',
      attendees: members,
      numAttendees: map['num_attendees'] ?? 0,
      maxAttendees: map['max_attendees'] ?? 0,
    );
  }
}
