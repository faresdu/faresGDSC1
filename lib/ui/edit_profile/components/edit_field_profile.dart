import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/widgets/custom_text_form_field.dart';

class EditFieldProfile {
  Widget textField(String title, TextEditingController controller) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        child: CustomTextFormField(
          controller: controller,
          title: title,
        ));
  }
}
