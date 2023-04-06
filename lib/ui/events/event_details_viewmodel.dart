import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:stacked/stacked.dart';

import '../../core/app/app.locator.dart';
import '../../core/models/member.dart';
import '../../core/services/event_service.dart';
import '../../core/services/supabase_service.dart';
import '../../core/services/user_service.dart';
import '../../core/utils/constants.dart';
import 'components/event_details_signup_button.dart';

class EventsDetailsViewModel extends StreamViewModel<List<Event>> {
  final eventService = locator<EventService>();
  final supabaseService = locator<SupabaseService>();
  final userService = locator<UserService>();

  late Event eventDetails;

  EventsDetailsViewModel(this.eventDetails);

  @override
  Stream<List<Event>> get stream => eventService.eventsController.stream;

  @override
  void onData(List<Event>? data) {
    super.onData(data);
    if (data != null) {
      eventDetails = data.firstWhere((e) => e.eventID == eventDetails.eventID);
    }
  }

  Widget getSignUpButton(Event event) {
    if (signedUp(event)) {
      return EventDetailsSignupButton(
        text: 'سجل خروج',
        onPressed: () {
          signOutFromEvent(event);
        },
        color: Constants.grey.withOpacity(.9),
      );
    } else if (event.isFull()) {
      return EventDetailsSignupButton(
        text: 'المقاعد ممتلئة',
        onPressed: () {
          print('cant');
        },
        color: Constants.red.withOpacity(.9),
      );
    } else if (event.getPercentage() >= 75) {
      return EventDetailsSignupButton(
        text: 'احجز مقعدك',
        onPressed: () {
          signUpToEvent(event);
        },
        color: Constants.yellow.withOpacity(.9),
      );
    }
    return EventDetailsSignupButton(
      text: 'احجز مقعدك',
      onPressed: () {
        signUpToEvent(event);
      },
      color: Constants.green.withOpacity(.9),
    );
  }

  bool signedUp(Event event) {
    for (Member m in event.attendees) {
      if (m.id == userService.user.id) {
        return true;
      }
    }
    return false;
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
}
