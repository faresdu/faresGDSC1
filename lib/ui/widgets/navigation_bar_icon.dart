import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigationBarIcon extends StatelessWidget {
  const NavigationBarIcon({Key? key, required this.filename}) : super(key: key);
  final String filename;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(filename, color: IconTheme.of(context).color);
  }
}
