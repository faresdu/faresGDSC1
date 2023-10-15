import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';

class HierarchyButton extends StatelessWidget {
  final void Function() onPressed;
  final String name;

  const HierarchyButton({Key? key, required this.onPressed, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8),
          backgroundColor: Constants.primaryLightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(name,
              style: Constants.veryLargeText.copyWith(
                fontWeight: FontWeight.bold,
                color: Constants.white,
              )),
        ),
      ),
    );
  }
}
