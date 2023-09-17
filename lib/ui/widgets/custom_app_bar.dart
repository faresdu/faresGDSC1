import 'package:flutter/material.dart';
import '../../core/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title = '',
      this.leading,
      this.actions,
      this.leadingWidth,
      this.preferredSize = const Size.fromHeight(65)});
  @override
  final Size preferredSize;

  final String title;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      backgroundColor: Constants.white,
      foregroundColor: Constants.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
