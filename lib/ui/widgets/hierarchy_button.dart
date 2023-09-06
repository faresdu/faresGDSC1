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
      padding: const EdgeInsets.only(top: 20),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // <-- Radius
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            backgroundColor: Constants.primaryLightBlue),
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
