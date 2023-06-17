import 'dart:async';

import 'package:gdsc_app/core/services/notification_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';
import '../../core/app/app.locator.dart';
import '../../core/models/notifications.dart';

class NotificationsViewModel extends FutureViewModel {
  final notificationService = locator<NotificationService>();
  final userService = locator<UserService>();

  List<Notifications> notifications = [];

  Future getNotifications() async {
    notifications = await notificationService.getNotifications();
    notifyListeners();
  }

  @override
  Future futureToRun() => getNotifications();
}
