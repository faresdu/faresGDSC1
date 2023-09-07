import 'package:flutter/material.dart';

import 'event_type.dart';
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
  final DateTime? endDate;
  List<Member> attendees;
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
    this.endDate,
    required this.attendees,
    required this.maxAttendees,
    required this.location,
    this.host,
    required this.isOnline,
  });

  int getRemainingSeats() {
    if (isFull()) return 0;
    return maxAttendees - attendees.length;
  }

  double getPercentage() {
    if (isFull()) return 100;
    if (maxAttendees == 0) return 0;
    return 100.0 * attendees.length / maxAttendees;
  }

  bool isFull() {
    return attendees.length >= maxAttendees;
  }

  bool isOwner(String id) {
    return instructorID == id;
  }

  bool isSignedUp(String id) {
    for (Member m in attendees) {
      if (m.id == id) {
        return true;
      }
    }
    return false;
  }

  Widget getImage() {
    if (flyer != null) {
      return Image.network(flyer!);
    }
    return Image.asset('assets/images/temp-events-img.png');
  }

  Map<String, dynamic> toJson() {
    return {
      'instructor_id': instructorID,
      'title': title,
      'start_date': startDate.toString(),
      'location': location,
      'max_attendees': maxAttendees,
      'is_online': isOnline,
      'flyer': flyer,
      'description': description,
      'end_date': endDate?.toString(),
      'event_host': host,
    };
  }

  factory Event.fromJson(Map<String, dynamic> map) {
    List<Member> members = [];
    if (map["attendees"] != null && (map['attendees'] as List).first != null && (map['attendees'] as List).first['user_id'] != null) {
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
      startDate: DateTime.tryParse(map['start_date'] ?? '') ?? DateTime.utc(1900),
      endDate: DateTime.tryParse(map['end_date'] ?? ''),
      attendees: members,
      maxAttendees: map['max_attendees'] ?? 0,
      location: map['location'] ?? '',
      host: map['event_host'],
      isOnline: map['is_online'] ?? false,
    );
  }

  EventType getType(String userId) {
    if (startDate.isBefore(DateTime.now())) {
      return EventType.isExpired();
    }
    if (isFull()) {
      return EventType.isFull();
    }
    if (isSignedUp(userId)) {
      return EventType.isSignedUp();
    }
    if (getPercentage() >= 75) {
      return EventType.isAlmostFull();
    }
    return EventType.isEmpty();
  }
}
