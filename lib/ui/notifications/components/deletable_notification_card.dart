import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/notifications.dart';
import 'package:gdsc_app/ui/notifications/components/notification_card.dart';
import 'package:gdsc_app/ui/widgets/deletable_item_card.dart';

class DeletableNotificationCard extends StatelessWidget {
  const DeletableNotificationCard(
      {Key? key, required this.notification, required this.onDelete})
      : super(key: key);
  final Notifications notification;
  final void Function(Notifications notification) onDelete;

  @override
  Widget build(BuildContext context) {
    return DeletableItemCard(
        item: notification,
        onDelete: onDelete,
        widget: NotificationCard(
          notification: notification,
        ));
  }
}
