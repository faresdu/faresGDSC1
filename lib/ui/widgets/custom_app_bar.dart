import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.leading,
    this.actions,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: leading,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          title,
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w500,
              color: Constants.black,
            ),
          ),
        ),
      ),
      actions: actions,
      centerTitle: true,
      toolbarHeight: 100,
    );
  }
}
