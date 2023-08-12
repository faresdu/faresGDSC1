import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.title,
    this.maxLines = 1,
    this.autofocus = false,
    required this.controller,
    this.icon,
    this.type,
    this.validator,
    this.onSaved,
    this.maxLength,
    Key? key,
  }) : super(key: key);
  final String? title;
  final TextEditingController controller;
  final bool autofocus;
  final int maxLines;
  final int? maxLength;
  final Widget? icon;
  final TextInputType? type;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            onSaved: onSaved,
            decoration: InputDecoration(
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
