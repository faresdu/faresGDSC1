import 'package:gdsc_app/core/utils/string_extensions.dart';

class FormValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty || value.isValidEmail) {
      return 'الرجاء إدخال بريد الكتروني او رقم جامعي صحيح';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'الرجاء إدخال كلمة سر صحيحة';
    }
    return null;
  }

  static String? studentIDValidator(String? value, viewmodel) {
    //if the value is Integer(Student ID)
    try {
      if (int.parse(value!) != null) {
        viewmodel.isNumber = true;
        return null;
      } else {
        viewmodel.isNumber = false;
      }
    } catch (e) {}
    //validate email
    return 'الرجاء إدخال بريد الكتروني او رقم جامعي صحيح';
  }
}
