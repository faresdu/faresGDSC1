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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: SizedBox(
        width: 160,
        child: MaterialButton(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 3,
          onPressed: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              HelperFunctions.eventImage(
                imageUrl: event.flyer,
                height: 90,
                width: 90,
              ),
              Text(
                event.title,
                style: Constants.extraSmallText.copyWith(
                  color: Constants.black,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "${DateHelper.getDate(event.startDate)}  -  ${event.isOnline ? "اونلاين" : "حضوري"}",
                style: Constants.superSmallText.copyWith(
                    color: Constants.grey, fontWeight: FontWeight.bold),
              ),
              signUpButton,
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
