import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {required this.text,
      required this.onPressed,
      this.isBusy = false,
      Key? key})
      : super(key: key);
  final String text;
  final bool isBusy;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(double.infinity, 35),
        backgroundColor: Constants.blueButton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: isBusy
          ? const CircularProgressIndicator()
          : Text(
              text,
              style: Constants.verySmallText.copyWith(
                  color: Constants.white, fontWeight: FontWeight.w700),
            ),
    );
  }
}
