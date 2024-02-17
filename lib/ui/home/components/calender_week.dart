import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class CalenderWeek extends StatelessWidget {
  const CalenderWeek({
    super.key,
    required this.currentWeek,
  });

  final int? currentWeek;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.asset("assets/icons/calender.png").image),
      ),
      child: Text(
        "${currentWeek!}",
        style: Constants.largeText
            .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
