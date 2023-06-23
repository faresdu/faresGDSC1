import 'package:flutter/material.dart';

import '../../../core/models/volunteer_hours.dart';
import '../../../core/utils/constants.dart';

class ProfileVolunteerHoursCardBig extends StatelessWidget {
  const ProfileVolunteerHoursCardBig({
    super.key,
    required this.volunteerHours,
  });

  final VolunteerHours volunteerHours;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Constants.white,
        boxShadow: Constants.cardShadow,
      ),
      child: Row(
        children: [
          Text(volunteerHours.reasoning ?? 'no reason'),
          Text(volunteerHours.hours.toString()),
        ],
      ),
    );
  }
}
