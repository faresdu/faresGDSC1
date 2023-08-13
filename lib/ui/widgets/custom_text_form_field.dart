import 'package:flutter/material.dart';

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
    this.onTap,
    this.enableInteractiveSelection,
    this.autoValidate = true,
    Key? key,
  }) : super(key: key);
  final String? title;
  final String? hintText;
  final TextEditingController controller;
  final void Function(String)? onChange;
  final bool autofocus;
  final int maxLines;
  final int? maxLength;
  final Widget? icon;
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
          : const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          const SizedBox(
            height: 7,
          ),
          TextFormField(
            maxLength: maxLength,
            keyboardType: type,
            maxLines: maxLines,
            autofocus: autofocus,
            controller: controller,
            validator: validator,
            onChanged: onChange,
            onSaved: onSaved,
            autovalidateMode: autovalidateMode,
            onTap: enableInteractiveSelection == false && onTap != null
                ? () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    onTap!();
                  }
                : onTap,
            enableInteractiveSelection: enableInteractiveSelection,
            decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: icon,
                ),
                prefixIconConstraints: const BoxConstraints(maxWidth: 22 + 30),
                contentPadding: (maxLines > 1
                    ? const EdgeInsets.symmetric(vertical: 10)
                    : EdgeInsets.zero),
                fillColor: Colors.white,
                filled: true,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
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
        ],
      ),
    );
  }
}
