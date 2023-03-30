import 'member.dart';

class Event {
  final String instructorID;
  final String instructor;
  final String title;
  final String flyer;
  final String description;
  final String date;
  final String time;
  final String location;
  final List<Member> attendees;
  final int numAttendees;
  final int maxAttendees;

  Event({
    required this.instructorID,
    required this.title,
    required this.flyer,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.attendees,
    required this.numAttendees,
    required this.maxAttendees,
    required this.instructor,
  });

  factory Event.fromJson(Map<String, dynamic> map) {
    return Event(
      instructorID: map['instructor_id'] ?? '',
      instructor: map['name'] ?? '',
      title: map['title'] ?? '',
      flyer: map['flyer'] ?? '',
      description: map['description'] ?? '',
      date: map['start_date'] ?? '',
      time: map['start_time'] ?? '',
      location: map['place'] ?? '',
      attendees: map['attendees'] ?? '',
      numAttendees: map['num_attendees'] ?? '',
      maxAttendees: map['max_attendees'] ?? '',
    );
  }
}
