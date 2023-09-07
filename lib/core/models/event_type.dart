import 'dart:ui';

import 'package:gdsc_app/core/enums/event_type_ids.dart';

import '../utils/constants.dart';

class EventType {
  String text;
  Color color;
  int id;

  EventType({
    required this.text,
    required this.color,
    required this.id
  });

  factory EventType.isExpired() {
    return EventType(text: 'الفعاليه منتهية', color: Constants.grey, id: EventTypeIDs.isExpired);
  }

  factory EventType.isSignedUp() {
    return EventType(text: 'سجل خروج', color: Constants.red, id: EventTypeIDs.isSignedUp);
  }

  factory EventType.isFull() {
    return EventType(text: 'المقاعد ممتلئة', color: Constants.grey, id: EventTypeIDs.isFull);
  }

  factory EventType.isAlmostFull() {
    return EventType(text: 'احجز مقعدك', color: Constants.blueButton, id: EventTypeIDs.isAlmostFull);
  }

  factory EventType.isEmpty() {
    return EventType(text: 'احجز مقعدك', color: Constants.green, id: EventTypeIDs.isEmpty);
  }
}