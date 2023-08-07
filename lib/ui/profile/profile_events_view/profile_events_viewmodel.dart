import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/services/event_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/events/components/events_card_signup_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileEventsViewModel extends StreamViewModel<List<Event>> {
  final navService = locator<NavigationService>();
  final eventService = locator<EventService>();
  final userService = locator<UserService>();

  final key = GlobalKey(debugLabel: 'profile_events');

  List<Event> events = [];
  late Member user;
  ProfileEventsViewModel() {
    user = userService.user;
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
    if (event.isSignedUp(userService.user.id)) {
      return EventCardButton(
        text: 'سجل خروج',
        color: Constants.red.withOpacity(.9),
        onPressed: () async {
          await eventService.signOutFromEvent(event.eventID);
        },
      );
    } else if (event.isFull()) {
      return EventCardButton(
        text: 'المقاعد ممتلئة',
        color: Constants.grey.withOpacity(.4),
        onPressed: null,
      );
    } else if (event.startDate.isAfter(DateTime.now())) {
      return EventCardButton(
        text: 'الفعاليه منتهيه',
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
