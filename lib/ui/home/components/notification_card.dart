import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

import '../../../core/models/notifications.dart';
import '../../../core/utils/constants.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {super.key, required this.notification, this.isNetworkImage = true});

  final Notifications notification;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Constants.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                //"أكملت 30 ساعة تطوعية",
                notification.title,
                style: const TextStyle(
                  fontSize: 22,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
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
            ],
          ),
          const Spacer(),
          if (notification.picture != null && isNetworkImage)
            HelperFunctions.profileImage(
                imageUrl: notification.picture!,
                height: 60,
                width: 60,
                fit: BoxFit.contain),
          if (notification.picture != null && !isNetworkImage)
            Image.asset(notification.picture!,
                height: 60, width: 60, fit: BoxFit.contain)
        ],
      ),
    );
  }
}
