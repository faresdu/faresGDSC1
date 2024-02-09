import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class RoundedSubmitButton extends StatelessWidget {
  const RoundedSubmitButton(
      {required this.text,
      required this.onPressed,
      this.isBusy = false,
      this.fixedSize = const Size(90, 40),
      super.key});
  final Size? fixedSize;
  final String text;
  final bool isBusy;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isBusy ? null : onPressed,
      style: TextButton.styleFrom(
        fixedSize: fixedSize,
        backgroundColor: isBusy ? Constants.greyDivider : Constants.blueButton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: isBusy
          ? const CircularProgressIndicator(
              color: Constants.white,
            )
          : Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}
