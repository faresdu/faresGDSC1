import 'package:form_builder_validators/form_builder_validators.dart';

class FormValidators {
  static String? emailValidator(String? value, {String? message}) {
    return FormBuilderValidators.compose<String>([
      FormBuilderValidators.required(
          errorText:
              message ?? ' الرجاء إدخال البريد الكتروني او الرقم الجامعي'),
      FormBuilderValidators.email(
          errorText: message ?? 'الرجاء إدخال بريد الكتروني او رقم جامعي صحيح'),
    ])(value);
  }

  static String? maxCharsValidator(String? value, int maxChars) {
    if (value == null || value.isEmpty) {
      return 'الرجاء تعبئة الخانه';
    } else if (value.length > maxChars) {
      return "الرجاء ادخال عدد احرف اقل من $maxChars حرف";
    }
    return null;
  }

  static String? minCharsValidator(String? value, int minChars) {
    return FormBuilderValidators.compose<String>([
      FormBuilderValidators.required(errorText: 'الرجاء تعبئة الخانه'),
      FormBuilderValidators.minLength(minChars,
          errorText: "الرجاء ادخال عدد احرف اكبر من $minChars حرف")
    ])(value);
  }

  static String? hoursValidator(String? value, {int maxHours = 100}) {
    return FormBuilderValidators.compose<String>([
      FormBuilderValidators.required(errorText: 'الرجاء إدخال عدد الساعات'),
      FormBuilderValidators.numeric(errorText: 'الرجاء إدخال عدد الساعات'),
      FormBuilderValidators.min(1,
          errorText: ' الرجاء إدخال عدد الساعات اكبر من ساعة'),
      FormBuilderValidators.max(maxHours,
          errorText: 'الرجاء إدخال عدد الساعات اقل من $maxHours ساعة')
    ])(value);
  }

  static String? eventAttendeesValidator(String? value,
      {int maxAttendees = 150}) {
    return FormBuilderValidators.compose<String>([
      FormBuilderValidators.required(errorText: 'الرجاء إدخال عدد الحضور'),
      FormBuilderValidators.numeric(errorText: 'الرجاء إدخال عدد الحضور'),
      FormBuilderValidators.integer(errorText: 'الرجاء إدخال عدد الحضور'),
      FormBuilderValidators.min(1, errorText: 'ادخل عدد حضور اكبر من صفر'),
      FormBuilderValidators.max(maxAttendees,
          errorText: 'ادخل عدد حضور اقل من $maxAttendees')
    ])(value);
  }

  static String? linkValidator(String? value, {bool required = true}) {
    return FormBuilderValidators.compose<String>([
      if (required)
        FormBuilderValidators.required(errorText: 'الرجاء ادخال رابط المنصه'),
      FormBuilderValidators.url(errorText: 'الرجاء ادخال رابط صحيح')
    ])(value);
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'الرجاء إدخال كلمة سر صحيحة';
    }
    return null;
  }

  static String? studentIDValidator(String? value) {
    return FormBuilderValidators.compose<String>([
      FormBuilderValidators.required(
          errorText: 'الرجاء إدخال البريد الكتروني او الرقم الجامعي'),
      FormBuilderValidators.numeric(
          errorText: 'الرجاء إدخال البريد الكتروني او الرقم الجامعي'),
      FormBuilderValidators.maxLength(10,
          errorText: 'الرجاء إدخال بريد الكتروني او رقم جامعي صحيح')
    ])(value);
  }
}
