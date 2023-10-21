import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

import '../../../core/models/notifications.dart';
import '../../../core/utils/constants.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {super.key, required this.notification});

  final Notifications notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Constants.white,
          boxShadow: Constants.shadow),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width* 0.63,
                child: Text(
                  //"أكملت 30 ساعة تطوعية",
                  notification.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 22,
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                //"أكملت لجنتك 500 ساعة تطوعية",
                notification.name,
                style: const TextStyle(
                  height: 1.6,
                  fontSize: 17,
                  letterSpacing: -0.25,
                  color: Constants.black2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
            ],
          ),
          HelperFunctions.notificationImage(
              imageUrl: notification.picture ?? '',
              height: 60,
              width: 60,
              fit: BoxFit.contain),
        ],
      ),
    );
  }
}
