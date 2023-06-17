import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.onPressed});
  final String title;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0.25),
          ),
          InkWell(
            onTap: onPressed,
            child: Text(
              "عرض المزيد",
              style: Constants.smallText.copyWith(height: 1.6, letterSpacing: -0.25, color: Constants.black2),
            ),
          ),
        ],
      ),
    );
  }
}
