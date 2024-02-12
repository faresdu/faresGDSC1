import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title = '',
      this.bottom,
      this.leading,
      this.actions,
      this.elevation = 0,
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
    return Container(
      decoration: BoxDecoration(boxShadow: kElevationToShadow[3]),
      child: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: elevation,
        backgroundColor: Constants.white,
        foregroundColor: Constants.black,
        shape: roundedBorder
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius))
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
        bottom: bottom,
      ),
    );
  }
}
