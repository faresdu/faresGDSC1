import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class EventDetailsSignupButton extends StatelessWidget {
  const EventDetailsSignupButton({
    Key? key,
    this.onPressed,
    required this.color,
    required this.text,
  }) : super(key: key);
  final Function()? onPressed;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: color,
            boxShadow: Constants.shadow2,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Constants.white),
          ),
        ),
      ),
    );
  }
}
