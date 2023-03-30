import 'member.dart';

class Event {
  final String eventID;
  final String instructorID;
  final String instructor;
  final String title;
  final String? flyer;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
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
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.attendees,
    required this.numAttendees,
    required this.maxAttendees,
    required this.instructor,
  });

  factory Event.placeholder() {
    return Event(
      instructorID: '123',
      title: 'مقدمة في علم البيانات',
      description:
          'ما أصله؟ خلافاَ للاعتقاد السائد فإن لوريم إيبسوم ليس نصاَ عشوائياً، بل إن له جذور في الأدب اللاتيني الكلاسيكي منذ العام 45 قبل الميلاد، مما يجعله أكثر من عام في',
      location: 'بهو الجامعة',
      attendees: [
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
        Member.anonymous(),
      ],
      startDate:
          DateTime.tryParse('2022-01-21 07:00:00+00') ?? DateTime.utc(1900),
      endDate:
          DateTime.tryParse('2022-01-21 11:00:00+00') ?? DateTime.utc(1900),
      instructor: 'بسام البسام',
      maxAttendees: 37,
      flyer: 'assets/images/temp-events-img.png',
      numAttendees: 2,
      eventID: '12',
    );
  }

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
      startDate: DateTime.tryParse(map['start_date']) ?? DateTime.utc(1900),
      endDate: DateTime.tryParse(map['end_date']) ?? DateTime.utc(1900),
      location: map['location'] ?? '',
      attendees: members,
      numAttendees: map['num_attendees'] ?? 0,
      maxAttendees: map['max_attendees'] ?? 0,
    );
  }
}
