import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/models/volunteer_hours.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/date_helper.dart';

class ProfileVolunteerHoursCardBig extends StatelessWidget {
  const ProfileVolunteerHoursCardBig({
    super.key,
    required this.volunteerHours,
    this.isOwner = false,
    this.onPressed,
  });

  final VolunteerHours volunteerHours;
  final bool isOwner;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Constants.cardBackground(context),
        boxShadow: Constants.cardShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    volunteerHours.reasoning == null ||
                            volunteerHours.reasoning!.trim().isEmpty
                        ? 'السبب لم يذكر'
                        : volunteerHours.reasoning!,
                    style: Constants.mediumText
                        .copyWith(fontWeight: FontWeight.w700, height: 1.4),
                  ),
                ),
                Text(
                  DateHelper.sincePosted(volunteerHours.createdAt),
                  style: Constants.verySmallText
                      .copyWith(color: Constants.black3(context)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/profile/clock.svg',
                      color: _getColor(),
                      width: 25,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      volunteerHours.hours.toString(),
                      style: Constants.smallText,
                    ),
                  ],
                ),
                if (isOwner && volunteerHours.isPending())
                  IconButton(
                      constraints: const BoxConstraints(),
                      onPressed: onPressed,
                      icon: SvgPicture.asset(
                        'assets/icons/profile/trash.svg',
                        height: 25,
                        color: Constants.negative,
                      ))
              ],
            )
          ],
        ),
      ),
    );
  }

  _getColor() {
    if (volunteerHours.isPending()) {
      return Constants.warning;
    } else if (volunteerHours.isAccepted()) {
      return Constants.positive;
    }
    return Constants.negative;
  }
}
