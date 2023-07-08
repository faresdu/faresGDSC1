import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gdsc_app/core/services/notification_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';
import '../../core/app/app.locator.dart';
import '../../core/models/notifications.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';

class NotificationsViewModel extends FutureViewModel {
  final notificationService = locator<NotificationService>();
  final userService = locator<UserService>();
  TextEditingController descriptionController = TextEditingController();

  List<Notifications> notifications = [];

  Future getNotifications() async {
    notifications = await notificationService.getNotifications();
    notifyListeners();
  }

  @override
  Future futureToRun() => getNotifications();

  addNotification(GDSCUser user) async {
    try {
      setBusy(true);
      await notificationService.addNotification(
          Notifications(
              title: descriptionController.value.text.trim(), name: user.name),
          user.id);
      await getNotifications();
    } catch (e) {
      print(e.toString());
    }
    setBusy(false);
  }
}
