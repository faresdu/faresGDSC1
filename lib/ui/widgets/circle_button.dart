import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';

class CircleButton extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final void Function() onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  const CircleButton(
      {this.child,
      required this.onPressed,
      this.padding,
      this.foregroundColor,
      this.backgroundColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Constants.primaryLightBlue,
        shape: const CircleBorder(),
        padding: padding ?? const EdgeInsets.all(10),
      ),
      child: child ?? const Icon(Icons.add),
    );
  }
}
