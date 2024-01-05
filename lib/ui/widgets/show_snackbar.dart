import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

void showSnackBar(context,
    {required bool success, required String message, Duration? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: duration ?? const Duration(milliseconds: 4000),
      showCloseIcon: true,
      backgroundColor: success ? Constants.green : Constants.red,
      content: Text(message,
          textAlign: TextAlign.center,
          style: Constants.mediumText.copyWith(color: Constants.white)),
    ),
  );
}
