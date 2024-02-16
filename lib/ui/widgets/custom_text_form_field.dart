import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.title,
    this.hintText,
    this.maxLines = 1,
    this.autofocus = false,
    required this.controller,
    this.onChange,
    this.icon,
    this.type,
    this.validator,
    this.onSaved,
    this.maxLength,
    this.shadow,
    this.onTap,
    this.enableInteractiveSelection,
    this.autoValidate = true,
    Key? key,
    this.style,
  }) : super(key: key);
  final String? title;
  final TextStyle? style;
  final String? hintText;
  final TextEditingController controller;
  final void Function(String)? onChange;
  final bool autofocus;
  final int maxLines;
  final int? maxLength;
  final Widget? icon;
  final List<BoxShadow>? shadow;
  final TextInputType? type;
  final bool? enableInteractiveSelection;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final bool autoValidate;

  @override
  Widget build(BuildContext context) {
    AutovalidateMode? autovalidateMode =
        autoValidate == true ? AutovalidateMode.onUserInteraction : null;
    return Container(
      margin: maxLength == null
          ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
          : const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: Constants.smallText.copyWith(
                color: Constants.black(context),
                fontWeight: FontWeight.w700,
              ),
            ),
          const SizedBox(
            height: 7,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: shadow,
            ),
            child: TextFormField(
              style: style,
              maxLength: maxLength,
              keyboardType: type,
              maxLines: maxLines,
              autofocus: autofocus,
              controller: controller,
              validator: validator,
              onChanged: onChange,
              onSaved: onSaved,
              autovalidateMode: autovalidateMode,
              enableInteractiveSelection: enableInteractiveSelection,
              onTap: enableInteractiveSelection == false && onTap != null
                  ? () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      onTap!();
                    }
                  : onTap,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: Constants.smallText.copyWith(
                    color: Constants.black3(context),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: icon,
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(maxWidth: 22 + 30),
                  contentPadding: (maxLines > 1
                      ? const EdgeInsets.symmetric(vertical: 10)
                      : EdgeInsets.zero),
                  fillColor: Constants.isDarkMode(context)
                      ? Colors.black.withOpacity(0.5)
                      : Constants.white,
                  filled: true,
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  counterStyle: Constants.smallText.copyWith(
                    color: Constants.black3(context),
                  ),
                  errorStyle: Constants.smallText.copyWith(
                    color: Constants.negative,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
