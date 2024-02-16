import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu(
      {required this.title,
      this.items,
      super.key,
      this.onChanged,
      this.autoValidate = true,
      this.errorMessage,
      this.hint});

  final List<DropdownMenuItem<String>>? items;
  final String title;
  final String? errorMessage;
  final void Function(String?)? onChanged;
  final String? hint;
  final bool autoValidate;

  @override
  Widget build(BuildContext context) {
    AutovalidateMode? autoValidateMode =
        autoValidate == true ? AutovalidateMode.onUserInteraction : null;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Constants.smallText.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                  autovalidateMode: autoValidateMode,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
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
                  onChanged: onChanged,
                  validator: (val) {
                    if (val == null) {
                      return errorMessage ?? 'الرجاء اختيار القيمة';
                    }
                    return null;
                  },
                  hint: Text(hint ?? 'اختر',
                      style: Constants.mediumText.copyWith(
                        fontWeight: FontWeight.w700,
                      )),
                  items: items))
        ],
      ),
    );
  }
}
