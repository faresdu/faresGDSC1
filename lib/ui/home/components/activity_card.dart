import 'package:flutter/material.dart';

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
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(6),
        width: 160,
        decoration: BoxDecoration(
          color: Constants.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            event.flyer != null
                ? Image.network(
                    event.flyer!,
                    width: 90,
                    height: 90,
                  )
                : Image.asset(
                    'assets/images/temp-events-img.png',
                    width: 90,
                    height: 90,
                  ),
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
