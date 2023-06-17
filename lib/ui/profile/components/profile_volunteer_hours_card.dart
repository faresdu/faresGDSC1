import 'package:flutter/material.dart';

import '../../../core/models/volunteer_hours.dart';
import '../../../core/utils/constants.dart';

class ProfileVolunteerHoursCard extends StatelessWidget {
  const ProfileVolunteerHoursCard({
    super.key,
    required this.volunteerHours,
  });

  final VolunteerHours volunteerHours;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      height: 55,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Constants.white, boxShadow: Constants.cardShadow),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          if (volunteerHours.isPending())
            const Icon(
              Icons.question_mark,
            ),
          if (volunteerHours.isAccepted())
            const Icon(
              Icons.done,
              color: Constants.green,
            ),
          if (!volunteerHours.isAccepted())
            const Icon(
              Icons.close,
              color: Constants.red,
            ),
          Expanded(
            child: Center(
              child: Text(
                volunteerHours.reasoning ?? 'no reason',
                style: const TextStyle(color: Constants.black),
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            color: Constants.darkBlue,
            child: Text(
              volunteerHours.hours.toString(),
              style: const TextStyle(color: Constants.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
