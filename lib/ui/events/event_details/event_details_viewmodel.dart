import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/app/app.locator.dart';
import '../../../core/services/event_service.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/services/user_service.dart';
import '../../../core/utils/constants.dart';
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

  get isOwner => eventDetails.instructorID == user.id;

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
    if (event.isSignedUp(user.id)) {
      return EventDetailsSignupButton(
        text: 'سجل خروج',
        color: Constants.red.withOpacity(.9),
        onPressed: () async {
          await eventService.signOutFromEvent(event.eventID);
        },
      );
    } else if (event.startDate.isAfter(DateTime.now())) {
      return EventDetailsSignupButton(
          text: 'الفعاليه منتهيه',
          color: Constants.grey.withOpacity(.9),
          onPressed: null);
    } else if (event.isFull()) {
      return EventDetailsSignupButton(
          text: 'المقاعد ممتلئة',
          color: Constants.grey.withOpacity(.9),
          onPressed: null);
    } else if (event.getPercentage() >= 75) {
      return EventDetailsSignupButton(
        text: 'احجز مقعدك',
        color: Constants.darkGrey.withOpacity(.9),
        onPressed: () async {
          await eventService.signUpToEvent(event.eventID);
        },
      );
    }
    return EventDetailsSignupButton(
      text: 'احجز مقعدك',
      color: Constants.darkBlue.withOpacity(.9),
      onPressed: () async {
        await eventService.signUpToEvent(event.eventID);
      },
    );
  }
}
