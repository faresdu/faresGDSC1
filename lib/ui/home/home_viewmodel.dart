import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/models/semester.dart';
import 'package:gdsc_app/core/services/hour_service.dart';
import 'package:gdsc_app/core/services/notification_service.dart';
import 'package:gdsc_app/core/services/semester_service.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/models/event.dart';
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
  final semesterService = locator<SemesterService>();

  late GDSCUser user;

  @override
  void onData(List<Event>? data) {
    super.onData(data);
    if (data != null) {
      events = data
          .where((e) => e.startDate.isAfter(DateTime.now()))
          .take(4)
          .toList();
      notifyListeners();
    }
  }

  List<Event> events = [];

  Notifications? featuredNotification;
  List<Notifications> notifications = [];
  List<Notifications> fullNotifications = [];
  late StreamSubscription userStream;
  late StreamSubscription semesterStream;
  int? currentWeek;

  Future init() async {
    setBusy(true);
    user = userService.user;
    userStream = userService.userSubject.listen((value) => user = value);
    semesterStream = semesterService.semesterSubject
        .listen((value) => currentWeek = getWeek(value));
    await setupNotifications();
    notifyListeners();
    setBusy(false);
  }

  Future<void> setupNotifications() async {
    await Future.wait([
      notificationService.getNotifications(limit: 3),
      getFeaturedNotification()
    ]).then((value) {
      fullNotifications = value[0] as List<Notifications>;
      featuredNotification = value[1] as Notifications?;
    });
    if (fullNotifications.isNotEmpty) {
      notifications = fullNotifications.take(4).toList();
    }
  }

  int getWeek(Semester semester) {
    return (DateHelper.getSemesterWeek(semester));
  }

  @override
  void dispose() async {
    await Future.wait([userStream.cancel(), semesterStream.cancel()]);
    super.dispose();
  }

  bool isHrAdmin() {
    return userService.user.isLeaderOrCoLeader() ||
        (userService.user.isHr() || userService.user.isAdmin);
  }

  Future<Notifications?> getFeaturedNotification() async {
    return Future.wait([
      hourService.getCumulativeHours(),
      hourService.getCumulativeCommitteeHours()
    ]).then((value) {
      int hours = value[0];
      int committeeHours = value[1];
      return Notifications(
        userId: '',
        title: "أكملت $hours ساعة تطوعية",
        name: "أكملت لجنتك $committeeHours ساعة تطوعية",
      );
    });
  }

  void navigateToCommitteesRequestsPage() {
    navService.navigateTo(Routes.committeesHoursView);
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
    await Future.wait([init(), userService.updateUser()]);

    notifyListeners();
    setBusy(false);
  }
}
