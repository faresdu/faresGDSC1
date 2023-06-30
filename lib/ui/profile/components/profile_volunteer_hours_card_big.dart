import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/models/volunteer_hours.dart';
import '../../../core/utils/constants.dart';

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
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Constants.white,
        boxShadow: Constants.cardShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  volunteerHours.reasoning == null ||
                          volunteerHours.reasoning!.trim().isEmpty
                      ? 'السبب لم يذكر'
                      : volunteerHours.reasoning!,
                  style: Constants.mediumText
                      .copyWith(fontWeight: FontWeight.w700),
                ),
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
              ],
            ),
            Column(
              children: [
                Text(
                  '15 hours',
                  style:
                      Constants.verySmallText.copyWith(color: Constants.grey),
                ),
                if (isOwner)
                  volunteerHours.isPending()
                      ? IconButton(
                          constraints: const BoxConstraints(),
                          onPressed: onPressed,
                          icon: SvgPicture.asset(
                            'assets/icons/profile/trash.svg',
                            height: 25,
                            color: Constants.red,
                          ))
                      : Container(
                          margin: EdgeInsets.all(4),
                          child: SvgPicture.asset(
                            'assets/icons/profile/trash.svg',
                            height: 25,
                            color: Constants.grey,
                          ),
                        )
              ],
            )
          ],
        ),
      ),
    );
  }

  _getColor() {
    if (volunteerHours.isPending())
      return Constants.yellow;
    else if (volunteerHours.isAccepted())
      return Constants.green;
    else
      return Constants.red;
  }
}
