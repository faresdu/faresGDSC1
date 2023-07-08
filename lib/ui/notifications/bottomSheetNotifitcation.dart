import 'package:flutter/material.dart';

void bottomSheetNotification(BuildContext context, Widget? child) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xffF1F1F1),
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(30), topLeft: Radius.circular(30)),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.7,
        child: child,
      );
    },
  );
}
