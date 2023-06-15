import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {super.key,
      required this.title,
      required this.body,
      required this.imagePath});
  final String title, body, imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),

      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Constants.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                //"أكملت 30 ساعة تطوعية",
                title,
                style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                //"أكملت لجنتك 500 ساعة تطوعية",
                body,
                style: TextStyle(
                  height: 1.6,
                  fontSize: 17,
                  letterSpacing: -0.25,
                  color: Constants.black2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Image.asset(imagePath)
        ],
      ),
    );
  }
}
