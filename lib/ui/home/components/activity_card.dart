import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class ActivityCard extends StatelessWidget {
  final Widget signUpButton;

  const ActivityCard({
    required this.signUpButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('inkwall');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.all(4),
        width: 140,
        decoration: BoxDecoration(
          color: Constants.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/temp-events-img.png',
              width: 80,
              height: 80,
            ),
            Text(
              "How To Learn Python",
              style: Constants.extraSmallText.copyWith(
                  fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
            ),
            Text(
              "2023/6/20  -  حضوري",
              style: Constants.superSmallText
                  .copyWith(color: Constants.grey, fontWeight: FontWeight.bold),
            ),
            signUpButton
          ],
        ),
      ),
    );
  }
}
