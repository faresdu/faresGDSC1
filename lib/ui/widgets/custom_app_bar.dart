import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title = '',
      this.bottom,
      this.leading,
      this.actions,
      this.elevation = 3,
      this.roundedBorder = true,
      this.radius = 10,
      this.leadingWidth,
      this.preferredSize = const Size.fromHeight(65)});

  @override
  final Size preferredSize;
  final PreferredSizeWidget? bottom;
  final double elevation;
  final bool roundedBorder;
  final double radius;
  final String title;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: Constants.cardBackground(context),
      foregroundColor: Constants.black(context),
      shape: roundedBorder
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))
          : null,
      leading: leading,
      leadingWidth: leadingWidth,
      title: Text(
        title,
        style: Constants.veryLargeText.copyWith(
          fontWeight: FontWeight.bold,
          color: Constants.black(context),
        ),
      ),
      actions: actions,
      centerTitle: true,
      bottom: bottom,
    );
  }
}
