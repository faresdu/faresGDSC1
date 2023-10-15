import 'package:flutter/material.dart';
import '../../core/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title = '',
      this.leading,
      this.actions,
      this.elevation = 3,
      this.roundedBorder = true,
      this.leadingWidth,
      this.preferredSize = const Size.fromHeight(65)});
  @override
  final Size preferredSize;
  final double elevation;
  final bool roundedBorder;
  final String title;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: Constants.white,
      foregroundColor: Constants.black,
      shape: roundedBorder
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          : null,
      leading: leading,
      leadingWidth: leadingWidth,
      title: Text(
        title,
        style: Constants.veryLargeText.copyWith(
          fontWeight: FontWeight.bold,
          color: Constants.black,
        ),
      ),
      actions: actions,
      centerTitle: true,
    );
  }
}
