import '../../core/models/event.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/services/event_service.dart';
import '../../core/services/user_service.dart';
import '../../core/utils/constants.dart';
import '../events/components/events_card_signup_button.dart';
import '../events/event_details/event_details_view.dart';

class HomeViewModel extends StreamViewModel<List<Event>> {
  final navService = locator<NavigationService>();
  final eventService = locator<EventService>();
  final userService = locator<UserService>();

  @override
  void onData(List<Event>? data) {
    super.onData(data);
    if (data != null) {
      events = data.take(4).toList();
      notifyListeners();
    }
  }

  List<Event> events = [];

  Map<String, String> mainNotification = {
    "title": "أكملت 30 ساعة تطوعية",
    "body": "أكملت لجنتك 500 ساعة تطوعية",
    "imagePath": "assets/images/achievement.png"
  };
  List<Map<String, String>> featuredNotifications = [
    {
      "title": "أكملت 36 ة",
      "body": "أكملت لجنتك 500 ساعة تطوعية",
      "imagePath": "assets/images/achievement.png"
    },
    {
      "title": "تعبئة صفحة الساعات",
      "body": "يوسف الغصن",
      "imagePath": "assets/images/empty.png"
    },
    {
      "title": "أكملت 30 ة",
      "body": "أكملت لجنتك 500 ساعة تطوعية",
      "imagePath": "assets/images/achievement.png",
    }
  ];

  navigateToRequestsPage() {
    navService.navigateTo(Routes.hoursRequestView);
  }

  Widget getSignUpButton(Event event) {
    if (event.isSignedUp(userService.user.id)) {
      return EventCardButton(
        text: 'سجل خروج',
        padding: EdgeInsets.symmetric(horizontal: 2),
        fontSize: 12,
        height: 0,
        color: Constants.red.withOpacity(.9),
        onPressed: () async {
          await eventService.signOutFromEvent(event.eventID);
        },
      );
    } else if (event.isFull()) {
      return EventCardButton(
        text: 'المقاعد ممتلئة',
        padding: EdgeInsets.symmetric(horizontal: 2),
        fontSize: 12,
        height: 0,
        color: Constants.grey.withOpacity(.4),
        onPressed: () {
          //show dialog
          print('cant');
        },
      );
    } else if (event.getPercentage() >= 75) {
      return EventCardButton(
        text: 'سجل - مقاعد محدودة',
        padding: EdgeInsets.symmetric(horizontal: 2),
        fontSize: 12,
        height: 0,
        color: Constants.blueButton.withOpacity(.9),
        onPressed: () async {
          await eventService.signUpToEvent(event.eventID);
        },
      );
    }
    return EventCardButton(
      text: 'سجل',
      padding: EdgeInsets.symmetric(horizontal: 2),
      fontSize: 12,
      height: 0,
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

  @override
  Stream<List<Event>> get stream => eventService.eventsController.stream;
}
