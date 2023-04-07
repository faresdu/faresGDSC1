import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/app/app.locator.dart';
import '../../core/models/member.dart';
import '../../core/services/event_service.dart';
import '../../core/services/supabase_service.dart';
import '../../core/utils/constants.dart';
import 'package:gdsc_app/ui/events/components/event_signup_cardbutton.dart';

import 'event_details_view.dart';

class EventsViewModel extends StreamViewModel<List<Event>> {
  final navService = locator<NavigationService>();
  final supabaseService = locator<SupabaseService>();
  final eventService = locator<EventService>();
  final userService = locator<UserService>();

  List<Event> events = [];

  EventsViewModel() {
    eventService.listenToAllEvents();
  }
  @override
  void onData(List<Event>? data) {
    super.onData(data);
    if (data != null) {
      events = data.toList();
      notifyListeners();
    }
  }


  Widget getSignUpCardButton(Event event) {
    if (event.isSignedUp(userService.user.id)) {
      return EventCardButton(
        text: 'سجل خروج',
        color: Constants.grey.withOpacity(.9),
        onPressed: () {
          signOutFromEvent(event);
        },
      );
    } else if (event.isFull()) {
      return EventCardButton(
        text: 'المقاعد ممتلئة',
        color: Constants.red.withOpacity(.9),
        onPressed: () {
          print('cant sign in');
        },
      );
    } else if (event.getPercentage() >= 75) {
      return EventCardButton(
        text: 'احجز مقعدك',
        color: Constants.yellow.withOpacity(.9),
        onPressed: () {
          signUpToEvent(event);
        },
      );
    }
    return EventCardButton(
      text: 'احجز مقعدك',
      color: Constants.green.withOpacity(.9),
      onPressed: () {
        signUpToEvent(event);
      },
    );
  }

  navigateToEvent(BuildContext context, Event event) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EventDetailsView(event: event);
        },
      ),
    );
  }

  // for loaction name on Eventcard to avoid layout overflow made by long loaction name
  static String locationEventName(String locationName) {
    if (locationName.length > 10) {
      return '...${locationName.substring(0, 12)}';
    }
    return locationName;
  }

  @override
  Stream<List<Event>> get stream => eventService.eventsController.stream;

  signUpToEvent(Event event) {
    try {
      supabaseService.signUpToEvent(event.eventID, userService.user.id);
      event.attendees.add(userService.user);
      event.numAttendees++;
      notifyListeners();
    } catch (e) {
      print('error signing up: $e');
    }
  }

  signOutFromEvent(Event event) {
    try {
      supabaseService.signOutFromEvent(event.eventID, userService.user.id);
      for (Member m in event.attendees) {
        if (m.id == userService.user.id) {
          event.attendees.remove(m);
          event.numAttendees--;
          notifyListeners();
          break;
        }
      }
    } catch (e) {
      print('error signing out: $e');
    }
  }
}
