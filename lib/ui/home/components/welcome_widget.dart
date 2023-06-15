import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';

class Welcome extends StatelessWidget {
  const Welcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: Constants.shadow6),
            child: Image.asset(
              "assets/images/avatar.png",
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "أهلا يوسف",
              style: Constants.veryLargeText.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "اللجنة التقنية",
              style: TextStyle(height: 1, color: Constants.black2),
            ),
          ],
        ),
      ],
    );
  }
}
