import 'member.dart';

class Event {
  final String eventID;
  final String instructorID;
  final String instructorName;
  final String? instructorProfilePicture;
  final String title;
  final String? flyer;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  List<Member> attendees;
  int numAttendees;
  final int maxAttendees;
  final String location;
  final String? host;
  final bool isOnline;

  Event({
    required this.eventID,
    required this.instructorID,
    required this.instructorName,
    this.instructorProfilePicture,
    required this.title,
    this.flyer,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.attendees,
    required this.numAttendees,
    required this.maxAttendees,
    required this.location,
    this.host,
    required this.isOnline,
  });

  int getRemainingSeats() {
    return maxAttendees - numAttendees;
  }

  double getPercentage() {
    if (numAttendees == 0) return 0;
    return 100.0 * numAttendees / maxAttendees;
  }

  bool isFull() {
    return numAttendees >= maxAttendees;
  }

  factory Event.placeholder() {
    return Event(
      eventID: '1234',
      instructorID: '123',
      instructorName: 'بسام البسام',
      title: 'مقدمة في علم البيانات',
      flyer: 'assets/images/temp-events-img.png',
      description:
          'ما أصله؟ خلافاَ للاعتقاد السائد فإن لوريم إيبسوم ليس نصاَ عشوائياً، بل إن له جذور في الأدب اللاتيني الكلاسيكي منذ العام 45 قبل الميلاد، مما يجعله أكثر من عام في',
      startDate:
          DateTime.tryParse('2022-01-21 07:00:00+00') ?? DateTime.utc(1900),
      endDate:
          DateTime.tryParse('2022-01-21 11:00:00+00') ?? DateTime.utc(1900),
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
      numAttendees: 2,
      maxAttendees: 37,
      location: 'بهو الجامعة',
      isOnline: false,
    );
  }

  factory Event.fromJson(Map<String, dynamic> map) {
    List<Member> members = [];
    if (((map["attendees"] as List).first as Map)['user_id'] != null) {
      members = (map["attendees"] as List).map((e) {
        return Member.fromJson(e);
      }).toList();
    }
    return Event(
      eventID: map['event_id'] ?? '',
      instructorID: map['instructor_id'] ?? '',
      instructorName: map['name'] ?? '',
      instructorProfilePicture: map['profile_picture'],
      title: map['title'] ?? '',
      flyer: map['flyer'],
      description: map['description'],
      startDate: DateTime.tryParse(map['start_date']) ?? DateTime.utc(1900),
      endDate: DateTime.tryParse(map['end_date']) ?? DateTime.utc(1900),
      attendees: members,
      numAttendees: map['num_attendees'] ?? 0,
      maxAttendees: map['max_attendees'] ?? 0,
      location: map['location'] ?? '',
      host: map['event_host'],
      isOnline: map['is_online'] ?? false,
    );
  }
}
