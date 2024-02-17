import 'package:flutter/material.dart';

import '../../../core/models/member.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/helper_functions.dart';

class EventAttendees extends StatelessWidget {
  const EventAttendees({
    Key? key,
    required this.attendees,
  }) : super(key: key);
  final List<Member> attendees;

  @override
  Widget build(BuildContext context) {
    List<Widget> images = [];
    if (attendees.isEmpty) {
      images.add(
        Align(
          widthFactor: .75,
          child: Container(
            decoration: BoxDecoration(boxShadow: Constants.shadow),
            child: CircleAvatar(
              backgroundColor: Constants.white,
              radius: 11,
              child: Text(
                '0',
                style: Constants.superSmallText.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    } else if (attendees.length > 3) {
      images.add(
        Align(
          widthFactor: .75,
          child: Container(
            decoration: BoxDecoration(boxShadow: Constants.shadow3),
            child: CircleAvatar(
              backgroundColor: Constants.white,
              radius: 11,
              child: Text(
                '+${attendees.length - 3}',
                style: Constants.superSmallText.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }
    for (int i = 0; i < 3 && i < attendees.length; i++) {
      images.add(
        Align(
          widthFactor: .75,
          child: Container(
            decoration: BoxDecoration(boxShadow: Constants.shadow3),
            child: CircleAvatar(
              radius: 11,
              backgroundColor: Constants.white,
              child: CircleAvatar(
                backgroundImage: HelperFunctions.avatarImageProvider(
                    imageUrl: attendees[i].photo ?? ''),
                backgroundColor: Colors.transparent,
                radius: 10,
              ),
            ),
          ),
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/icons/events/event-attendees.png', width: 13),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(
            'المشاركين',
            style: Constants.extraSmallText.copyWith(
                fontWeight: FontWeight.w500, color: Constants.black(context)),
          ),
        ),
        Row(children: images.reversed.toList()),
      ],
    );
  }
}
