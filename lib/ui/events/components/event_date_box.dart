import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class EventDateBox extends StatelessWidget {
  const EventDateBox({
    Key? key,
    required this.day,
    required this.month,
  }) : super(key: key);
  final int day;
  final String month;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
        color: Constants.grey.withOpacity(.1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(children: [
          Text(
            '$day',
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, height: 1),
          ),
          Text(
            month,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, height: 1),
          )
        ]),
      ),
    );
  }
}
