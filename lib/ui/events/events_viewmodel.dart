import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/models/member.dart';
import '../../core/services/supabase_service.dart';

class EventsViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  final userService = locator<SupabaseService>();
  List<Event> events = [];
  Event eventDetails = Event(
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
    startTime: DateTime.utc(1900),
    endTime: DateTime.utc(1900),
    date: DateTime.tryParse('2022-01-21') ?? DateTime.utc(1900),
    instructor: 'بسام البسام',
    maxAttendees: 37,
    flyer: 'assets/images/temp-events-img.png',
    numAttendees: 2,
    eventID: '12',
  );

  getEvents() async {
    await userService.getEvents().then((value) => events = value);
    notifyListeners();
  }

  getEvent(BuildContext context) {
    eventDetails = ModalRoute.of(context)!.settings.arguments! as Event;
  }

  navigateToEvent(Event event) async {
    // Event event = await userService.getEvent(id);
    // print(members.toString());
    navService.navigateTo(Routes.eventsDetailsView, arguments: event);
  }
}
