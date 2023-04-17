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
      margin: const EdgeInsets.all(10),
      height: 55,
      decoration: BoxDecoration(color: Constants.darkBlue, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                volunteerHours.hours.toString(),
                style: const TextStyle(color: Constants.white),
              ),
              Text(
                volunteerHours.reasoning ?? 'no reason',
                style: const TextStyle(color: Constants.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
