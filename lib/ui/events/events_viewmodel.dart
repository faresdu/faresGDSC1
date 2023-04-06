import 'package:flutter/material.dart';
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

import 'events_details_view.dart';

class EventsViewModel extends StreamViewModel<List<Event>> {
  final navService = locator<NavigationService>();
  final supabaseService = locator<SupabaseService>();
  final eventService = locator<EventService>();
  final userService = locator<UserService>();
  List<Event> events = [];
  late final Event eventDetails;

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

  getEvent(BuildContext context) {
    eventDetails = ModalRoute.of(context)!.settings.arguments! as Event;
  }

  bool signedUp(Event event) {
    for (Member m in event.attendees) {
      if (m.id == userService.user.id) {
        return true;
      }
    }
    return false;
  }

  Widget getSignUpCardButton(Event event) {
    if (signedUp(event)) {
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

  bool isOwner(Event event) {
    return event.instructorID == userService.user.id;
  }

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

  navigateToEvent(BuildContext context, Event event) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EventsDetailsView(event: event);
        },
      ),
    );
  }

  // for loaction name on Eventcard to avoid layout overflow made by long loaction name
  static String locationEventName(String locationName) {
    int j = 0;
    for (int i = 0; i < locationName.length; i++) {
      locationName[i];
      j++;
    }
    if (j > 10) {
      return '...${locationName.substring(0, 12)}';
    }
    return locationName;
  }

  @override
  Stream<List<Event>> get stream => eventService.eventsController.stream;
}
