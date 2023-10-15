import 'package:gdsc_app/core/services/hour_service.dart';
import 'package:gdsc_app/core/services/notification_service.dart';

import '../../core/models/event.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/models/event_type.dart';
import '../../core/models/notifications.dart';
import '../../core/services/event_service.dart';
import '../../core/services/user_service.dart';
import '../events/components/events_card_signup_button.dart';

class HomeViewModel extends StreamViewModel<List<Event>> {
  final navService = locator<NavigationService>();
  final eventService = locator<EventService>();
  final userService = locator<UserService>();
  final notificationService = locator<NotificationService>();
  final hourService = locator<HourService>();

  @override
  void onData(List<Event>? data) {
    super.onData(data);
    if (data != null) {
      events = data.where((e) => e.startDate.isAfter(DateTime.now())).take(4).toList();
      notifyListeners();
    }
  }

  List<Event> events = [];

  Notifications? featuredNotification;
  List<Notifications> notifications = [];
  List<Notifications> fullNotifications = [];

  Future getNotifications() async {
    setBusy(true);
    fullNotifications = await notificationService.getNotifications(limit: 3);
    featuredNotification = await getFeaturedNotification();
    if (fullNotifications.isNotEmpty) {
      notifications = fullNotifications.take(4).toList();
    }
    notifyListeners();
    setBusy(false);
  }

  bool isAdmin() {
    return userService.user.isLeaderOrCoLeader();
  }

  Future<Notifications?> getFeaturedNotification() async {
    int hours = await hourService.getCumulativeHours();
    int committeeHours = await hourService.getCumulativeCommitteeHours();

    return Notifications(
        title: "أكملت $hours ساعة تطوعية",
        name: "أكملت لجنتك $committeeHours ساعة تطوعية",
    );
  }

  void navigateToRequestsPage() {
    navService.navigateTo(Routes.hoursRequestView);
  }

  void navigateToNotifications() {
    navService.navigateTo(Routes.notificationView);
  }

  Widget getSignUpButton(Event event) {
    EventType type = eventService.getEventType(event);
    return EventCardButton(
      eventType: type,
    );
  }

  void navigateToEvent(Event event) async {
    navService.navigateTo(Routes.eventDetailsView, arguments: event);
  }

  @override
  Stream<List<Event>> get stream => eventService.eventsController.stream;

  Future<void> refreshData() async {
    setBusy(true);
    await getNotifications();
    notifyListeners();
    setBusy(false);
  }
}
