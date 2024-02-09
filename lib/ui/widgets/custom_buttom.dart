import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.height,
    this.textStyle,
    this.width,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width ?? 120, height ?? 35),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(7)),
        elevation: 3,
      ),
      onPressed: onPressed,
      child: Text(text, style: textStyle),
    );
  }
}
