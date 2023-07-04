import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';

void CustomModalBottomSheet(BuildContext context, Widget? child,
    {double heightFactor = 0.7, bool isScrollControlled = true}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: isScrollControlled,
    backgroundColor: Constants.grayBackGround,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(30), topLeft: Radius.circular(30)),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: heightFactor,
        child: child,
      );
    },
  );
}
