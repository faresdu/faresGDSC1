import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class EventInfoBox extends StatelessWidget {
  const EventInfoBox({
    Key? key,
    required this.topText,
    required this.bottomText,
    this.onPressed,
  }) : super(key: key);
  final String topText;
  final String bottomText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            topText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(bottomText,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Constants.grey))
        ],
      ),
    );
  }
}
