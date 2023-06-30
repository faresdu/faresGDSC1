import 'package:gdsc_app/core/utils/string_extensions.dart';

class FormValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty || !value.isValidEmail) {
      return 'الرجاء إدخال بريد الكتروني او رقم جامعي صحيح';
    }
    return null;
  }

  static String? maxCharsValidator(String? value, int maxChars) {
    if (value == null || value.isEmpty) {
      return 'الرجاء تعبئة الخانه';
    } else if (value.length > maxChars) {
      return "الرجاء ادخال عدد احرف اقل من $maxChars حرف";
    }
    return null;
  }

  static String? hoursValidator(String? value) {
    if (value == null || value.isEmpty || value.parseInt <= 0) {
      return 'الرجاء إدخال عدد الساعات';
    } else if (value.parseInt > 100) {
      return 'الرجاء إدخال عدد الساعات اقل من 100 ساعه';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'الرجاء إدخال كلمة سر صحيحة';
    }
    return null;
  }

  static String? studentIDValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 9 || !value.isNumber) {
      return 'الرجاء إدخال بريد الكتروني او رقم جامعي صحيح';
    }
    return null;
  }
}
