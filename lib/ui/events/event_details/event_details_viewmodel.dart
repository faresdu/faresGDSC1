import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/models/event_type.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/app/app.locator.dart';
import '../../../core/services/event_service.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/services/user_service.dart';
import '../components/event_details_signup_button.dart';

class EventsDetailsViewModel extends StreamViewModel<List<Event>> {
  final eventService = locator<EventService>();
  final supabaseService = locator<SupabaseService>();
  final userService = locator<UserService>();
  final navService = locator<NavigationService>();

  late Event eventDetails;
  late Member user;

  @override
  Stream<List<Event>> get stream => eventService.eventsController.stream;

  setEvent(BuildContext context) {
    eventDetails = ModalRoute.of(context)!.settings.arguments! as Event;
    user = userService.user;
  }

  get isOwner => eventDetails.instructorID == user.id || userService.user.isLeaderOrCoLeader();

  @override
  void onData(List<Event>? data) {
    super.onData(data);
    if (data != null) {
      eventDetails = data.firstWhere((e) => e.eventID == eventDetails.eventID);
    }
  }

  navigateToEventParticipants() {
    navService.navigateTo(Routes.eventParticipantsView,
        arguments: eventDetails.attendees.map((e) => e.id).toList());
  }

  Widget getSignUpButton(Event event) {
    EventType type = eventService.getEventType(event);
    return EventDetailsSignupButton(
      eventType: type,
    );
  }
}
