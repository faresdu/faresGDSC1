import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';

class LoginButton extends StatelessWidget {
  final void Function() onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 80),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Constants.darkBlue,
          shape: const StadiumBorder(),
        ),
        child: Text('سجل الدخول',
            style: Constants.mediumText
                .copyWith(fontWeight: FontWeight.w700, color: Colors.white)),
      ),
    );
  }
}
