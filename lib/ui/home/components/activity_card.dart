import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

import '../../../core/models/event.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/date_helper.dart';

class ActivityCard extends StatelessWidget {
  final Widget signUpButton;
  final Event event;
  final Function() onTap;

  const ActivityCard({
    required this.event,
    required this.onTap,
    required this.signUpButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          backgroundColor: Colors.white,
          fixedSize: const Size.fromWidth(160),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 3,
        ),
        onPressed: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HelperFunctions.eventImage(imageUrl: event.flyer, width: 90, height: 90),
            Text(
              event.title,
              style: Constants.extraSmallText.copyWith(
                  fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
            ),
            Text(
              "${DateHelper.getDate(event.startDate)}  -  ${event.isOnline ? "اونلاين" : "حضوري"}",
              style: Constants.superSmallText
                  .copyWith(color: Constants.grey, fontWeight: FontWeight.bold),
            ),
            signUpButton
          ],
        ),
      ),
    );
  }
}
