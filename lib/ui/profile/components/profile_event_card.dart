import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import '../../../core/utils/constants.dart';

class ProfileEventCard extends StatelessWidget {
  const ProfileEventCard({
    super.key,
    required this.event,
    this.onPressed,
  });
  final Function()? onPressed;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      decoration: BoxDecoration(
        color: Constants.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: Constants.shadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: const TextStyle(
                  color: Constants.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              Text(
                DateHelper.getDate(event.startDate),
                style: const TextStyle(
                  color: Constants.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: Constants.darkBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'معلومات اكثر',
              style: TextStyle(color: Constants.white),
            ),
          ),
        ],
      ),
    );
  }
}
