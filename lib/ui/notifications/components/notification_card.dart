import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

import '../../../core/models/notifications.dart';
import '../../../core/utils/constants.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});

  final Notifications notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Constants.white,
        boxShadow: kElevationToShadow[4],
      ),
      child: Row(
        children: [
          HelperFunctions.notificationImage(
            imageUrl: notification.picture ?? '',
            height: 60,
            width: 60,
            fit: BoxFit.contain,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (notification.createdAt != null)
                        Text(
                          DateHelper.postDateText(notification.createdAt!),
                          style: Constants.superSmallText,
                        ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      notification.title,
                      style: const TextStyle(
                        height: 1,
                        fontSize: 20,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Text(
                    notification.name,
                    style: const TextStyle(
                      height: 1.6,
                      fontSize: 16,
                      letterSpacing: -0.25,
                      color: Constants.black2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
