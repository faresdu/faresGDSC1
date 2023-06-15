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
      height: 100,
      width: 100,
      decoration: BoxDecoration(color: Constants.darkBlue, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          event.title,
          style: const TextStyle(color: Constants.white),
        ),
      ),
    );
  }
}
