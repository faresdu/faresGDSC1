import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/models/member.dart';
import '../../core/services/event_service.dart';
import '../../core/services/supabase_service.dart';
import '../../core/utils/constants.dart';
import 'package:gdsc_app/ui/events/components/events_card_signup_button.dart';

import 'components/events_card.dart';

class EventsViewModel extends StreamViewModel<List<Event>> {
  final navService = locator<NavigationService>();
  final supabaseService = locator<SupabaseService>();
  final eventService = locator<EventService>();
  final userService = locator<UserService>();

  List<Event> events = [];
  late Member user;
  EventsViewModel() {
    user = userService.user;
  }
  bool filtered = false;

  @override
  void onData(List<Event>? data) {
    super.onData(data);
    if (data != null) {
      events = data;
      notifyListeners();
    }
  }

  Widget getSignUpButton(Event event) {
    if (event.isSignedUp(userService.user.id)) {
      return EventCardButton(
          text: 'سجل خروج',
          color: Constants.red.withOpacity(.9),
          onPressed: () async {
            await eventService.signOutFromEvent(event.eventID);
          });
    } else if (event.isFull()) {
      return EventCardButton(
        text: 'المقاعد ممتلئة',
        color: Constants.grey.withOpacity(.4),
        onPressed: null,
      );
    } else if (event.getPercentage() >= 75) {
      return EventCardButton(
        text: 'احجز مقعدك - مقاعد محدودة',
        color: Constants.blueButton.withOpacity(.9),
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

  navigateToEvent(Event event) async {
    navService.navigateTo(Routes.eventDetailsView, arguments: event);
  }

  // for loaction name on Eventcard to avoid layout overflow made by long loaction name
  static String locationEventName(String locationName) {
    if (locationName.length > 13) {
      return '...${locationName.substring(0, 12)}';
    }
    return locationName;
  }

  @override
  Stream<List<Event>> get stream => eventService.eventsController.stream;

  bool canEditEvent(Event event) {
    return event.isOwner(userService.user.id);
  }

  bool canSeeOldEvents() {
    return userService.user.isLeaderOrCoLeader();
  }

  void switchFilter() {
    filtered = !filtered;
    notifyListeners();
  }

  List<Widget> getCards() {
    List<Event> eventList;
    if (filtered) {
      eventList =
          events.where((e) => e.startDate.isAfter(DateTime.now())).toList();
    } else {
      eventList = events;
    }
    return eventList
        .map(
          (e) => EventCard(
            event: e,
            signUpButton: getSignUpButton(e),
            canEdit: canEditEvent(e),
            onPressed: () {
              navigateToEvent(e);
            },
          ),
        )
        .toList();
  }
}
