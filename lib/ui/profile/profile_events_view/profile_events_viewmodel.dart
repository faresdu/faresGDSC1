import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/services/event_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:gdsc_app/ui/events/components/events_card_signup_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/models/event_type.dart';

class ProfileEventsViewModel extends StreamViewModel<List<Event>> {
  final navService = locator<NavigationService>();
  final eventService = locator<EventService>();
  final userService = locator<UserService>();

  final key = GlobalKey(debugLabel: 'profile_events');
  bool isUser = true;

  List<Event> events = [];
  late Member user;
  ProfileEventsViewModel(BuildContext context) {
    Member? member = (ModalRoute.of(context)!.settings.arguments as Member?);
    if (member != null) {
      user = member;
      isUser = false;
    } else {
      user = userService.user;
    }
  }

  @override
  void onData(List<Event>? data) {
    super.onData(data);
    if (data != null) {
      events = data.toList();
      notifyListeners();
    }
  }

  Widget getSignUpButton(Event event) {
    EventType type = eventService.getEventType(event);
    return EventCardButton(
      eventType: type,
    );
  }

  navigateToEvent(Event event) async {
    navService.navigateTo(Routes.eventDetailsView, arguments: event);
  }

  bool canEditEvent(Event event) {
    return event.isOwner(userService.user.id);
  }

  @override
  Stream<List<Event>> get stream => eventService.eventsController.stream;

  List<Event> get signedUpEvents =>
      events.where((e) => e.isSignedUp(user.id)).toList();

  List<Event> get createdEvents =>
      events.where((e) => e.isOwner(user.id)).toList();
}
