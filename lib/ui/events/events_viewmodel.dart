import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/app/app.locator.dart';
import '../../core/services/event_service.dart';
import '../../core/services/supabase_service.dart';
import '../../core/utils/constants.dart';
import 'package:gdsc_app/ui/events/components/events_card_signup_button.dart';

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
        onPressed: () async {
          await eventService.signOutFromEvent(event.eventID);
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
        onPressed: () async {
          await eventService.signUpToEvent(event.eventID);
        },
      );
    }
    return EventCardButton(
      text: 'احجز مقعدك',
      color: Constants.green.withOpacity(.9),
      onPressed: () async {
        await eventService.signUpToEvent(event.eventID);
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
}
