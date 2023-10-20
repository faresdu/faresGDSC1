import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/services/notification_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';
import '../../core/app/app.locator.dart';
import '../../core/models/notifications.dart';

class NotificationsViewModel extends FutureViewModel {
  final notificationService = locator<NotificationService>();
  final userService = locator<UserService>();
  TextEditingController descriptionController = TextEditingController();
  late GDSCUser user = userService.user;

  final formKey = GlobalKey<FormState>();

  List<Notifications> notifications = [];

  Future getNotifications() async {
    notifications = await notificationService.getNotifications();
    notifyListeners();
  }

  bool isAdmin() {
    return userService.user.isLeaderOrCoLeader();
  }

  @override
  Future futureToRun() => getNotifications();

  addNotification(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return null;
    }
    try {
      setBusy(true);
      await notificationService.addNotification(
          Notifications(
              title: descriptionController.value.text.trim(),
              name: userService.user.name),
          userService.user.id);
      await getNotifications();
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
    }
    setBusy(false);
  }
}
