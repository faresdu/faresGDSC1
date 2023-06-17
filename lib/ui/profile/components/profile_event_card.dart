import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import '../../../core/utils/constants.dart';

class ProfileEventCard extends StatelessWidget {
  const ProfileEventCard({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Constants.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: Constants.cardShadow,
      ),
      child: Column(children: [
        Expanded(child: event.getImage()),
        Text(
          event.title,
          style: const TextStyle(
            color: Constants.black,
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
        ),
      ]),
    );
  }
}
