import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

import '../../../core/models/notifications.dart';
import '../../../core/utils/constants.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});

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
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  //"أكملت 30 ساعة تطوعية",
                  notification.title,
                  overflow: TextOverflow.ellipsis,
                  style: Constants.largeText.copyWith(
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                //"أكملت لجنتك 500 ساعة تطوعية",
                notification.name,
                style: Constants.mediumText.copyWith(
                  height: 1.5,
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
              width: 60 > MediaQuery.of(context).size.width * 0.2
                  ? MediaQuery.of(context).size.width * 0.2
                  : 60,
              fit: BoxFit.contain),
        ],
      ),
    );
  }
}
