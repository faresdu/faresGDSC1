import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {required this.text,
      this.outlined = false,
      this.style,
      this.disabled = false,
      required this.onPressed,
      this.isBusy = false,
      Key? key,
      this.borderRadius,
      this.width,
      this.height,
      this.color})
      : super(key: key);
  final String text;
  final bool disabled;
  final bool isBusy;
  final bool outlined;
  final Color? color;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? style;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: disabled || isBusy ? null : onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size(width ?? double.infinity, height ?? 35),
        backgroundColor: outlined
            ? null
            : disabled
                ? Constants.lightGrey
                : color ?? Constants.blueButton,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10)),
      ),
      child: isBusy
          ? const CircularProgressIndicator()
          : Text(
              text,
              softWrap: true,
              textAlign: TextAlign.center,
              style: (style ?? Constants.verySmallText).copyWith(
                  color: outlined ? Constants.blueButton : Constants.white,
                  fontWeight: FontWeight.w700),
            ),
    );
  }
}
