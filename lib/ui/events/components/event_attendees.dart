import 'package:flutter/material.dart';

import '../../../core/models/member.dart';
import '../../../core/utils/constants.dart';

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
            decoration: BoxDecoration(boxShadow: Constants.shadow3),
            child: const CircleAvatar(
              backgroundColor: Constants.white,
              radius: 11,
              child: Text(
                '0',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Constants.black),
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
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Constants.black),
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
                backgroundImage: attendees[i].photo != null
                    ? NetworkImage(attendees[i].photo!)
                    : const AssetImage('assets/images/event-attendees.png')
                        as ImageProvider,
                backgroundColor: Constants.red,
                radius: 10,
              ),
            ),
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(image: AssetImage('assets/images/event-attendees.png')),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: const Text(
            'المشاركين',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Row(children: images),
      ],
    );
  }
}
