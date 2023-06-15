import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({Key? key, required this.onPressed, required this.color, required this.text, required this.imagePath}) : super(key: key);
  final void Function()? onPressed;
  final String imagePath;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 10,
      onPressed: onPressed,
      shape: const CircleBorder(eccentricity: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            height: 18,
            color: color,
          ),
          Text(text,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color,
              )),
        ],
      ),
    );
  }
}