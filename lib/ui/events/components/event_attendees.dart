import 'package:flutter/material.dart';

import '../../../core/models/member.dart';
import '../../../core/utils/constants.dart';

class EventAttendees extends StatelessWidget {
  const EventAttendees({Key? key, required this.attendees}) : super(key: key);
  final List<Member> attendees;

  @override
  Widget build(BuildContext context) {
    List<Widget> images = [];
    for (int i = 0; i < 3 && i < attendees.length; i++) {
      images.add(
        Align(
          widthFactor: .75,
          child: CircleAvatar(
            radius: 11,
            backgroundColor: Constants.white,
            child: CircleAvatar(
              backgroundImage: NetworkImage(attendees[i].photo ?? ''),
              backgroundColor: Constants.red,
              radius: 10,
            ),
          ),
        ),
      );
    }
    if (attendees.length > 3) {
      images.add(
        Container(
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
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Image(image: AssetImage('assets/images/event-attendees.png')),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'المشاركين',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Row(textDirection: TextDirection.ltr, children: images),
      ],
    );
  }
}
