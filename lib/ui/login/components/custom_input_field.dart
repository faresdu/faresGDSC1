import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  const CustomInputField(
      {Key? key, required this.hintText, this.validator, this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.right,
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Constants.verySmallText.copyWith(
            color: Constants.grey,
            fontWeight: FontWeight.w700,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Constants.darkBlue),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
