import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class EventSignupButton extends StatelessWidget {
  const EventSignupButton({
    Key? key,
    this.onPressed,
    required this.color
  }) : super(key: key);
  final Function()? onPressed;
  final Color color;

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
        child: const Center(
          child: Text(
            'احجز مقعدك',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Constants.white),
          ),
        ),
      ),
    );
  }
}
