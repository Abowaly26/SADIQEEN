import 'app_regex.dart';
import 'package:easy_localization/easy_localization.dart';

class AppValidation {
  // التحقق من الاسم
  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation_name_required'.tr();
    }
    if (value.length < 3) {
      return 'validation_name_min_length'.tr();
    }
    return null;
  }

  // التحقق من البريد الإلكتروني
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation_email_required'.tr();
    }
    if (!AppRegex.isEmailValid(value)) {
      return 'validation_email_invalid'.tr();
    }
    return null;
  }

  // التحقق من كلمة المرور
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation_password_required'.tr();
    }
    if (value.length < 6) {
      return 'validation_password_min_length'.tr();
    }
    if (!AppRegex.hasUpperCase(value) ||
        !AppRegex.hasLowerCase(value) ||
        !AppRegex.hasNumber(value)) {
      return 'validation_password_pattern'.tr();
    }
    return null;
  }

  // التحقق من تأكيد كلمة المرور
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'validation_confirm_password_required'.tr();
    }
    if (value != password) {
      return 'validation_password_mismatch'.tr();
    }
    return null;
  }

  // التحقق من رقم الهاتف
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation_phone_required'.tr();
    }
    if (!AppRegex.isPhoneNumberValid(value)) {
      return 'validation_phone_invalid'.tr();
    }
    return null;
  }

  // التحقق من اسم المستخدم
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation_username_required'.tr();
    }
    if (!AppRegex.isUsernameValid(value)) {
      return 'validation_username_invalid'.tr();
    }
    return null;
  }

  // التحقق من الحقول الفارغة
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '${'validation_field_required'.tr()} $fieldName';
    }
    return null;
  }

  // التحقق من الحد الأدنى للطول
  static String? validateMinLength(
    String? value,
    int minLength,
    String fieldName,
  ) {
    if (value == null || value.isEmpty) {
      return '${'validation_field_required'.tr()} $fieldName';
    }
    if (value.length < minLength) {
      return '$fieldName يجب أن يكون $minLength أحرف على الأقل';
    }
    return null;
  }

  // التحقق من الحد الأقصى للطول
  static String? validateMaxLength(
    String? value,
    int maxLength,
    String fieldName,
  ) {
    if (value == null || value.isEmpty) {
      return '${'validation_field_required'.tr()} $fieldName';
    }
    if (value.length > maxLength) {
      return '$fieldName يجب ألا يتجاوز $maxLength حرف';
    }
    return null;
  }
}
