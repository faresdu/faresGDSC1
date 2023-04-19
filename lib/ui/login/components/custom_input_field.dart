import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String?)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;

  const CustomInputField({
    Key? key,
    required this.hintText,
    this.validator,
    this.onSaved,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.right,
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Constants.verySmallText.copyWith(
            color: Constants.grey,
            fontWeight: FontWeight.w700,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Constants.grey),
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Constants.grey),
            borderRadius: BorderRadius.circular(50),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Constants.red),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Constants.darkBlue),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Constants.darkBlue),
            borderRadius: BorderRadius.circular(50),
          )),
      validator: validator,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      autofocus: autofocus,
      onTapOutside: (PointerDownEvent pointerDownEvent) {
        if (focusNode != null) {
          focusNode!.unfocus();
        }
      },
    );
  }
}
