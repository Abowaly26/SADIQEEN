import 'app_regex.dart';

class AppValidation {
  // التحقق من الاسم
  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك أدخل اسمك';
    }
    if (value.length < 3) {
      return 'الاسم يجب أن يكون 3 أحرف على الأقل';
    }
    return null;
  }

  // التحقق من البريد الإلكتروني
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك أدخل بريدك الإلكتروني';
    }
    if (!AppRegex.isEmailValid(value)) {
      return 'من فضلك أدخل بريد إلكتروني صحيح';
    }
    return null;
  }

  // التحقق من كلمة المرور
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك أدخل كلمة المرور';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    if (!AppRegex.hasUpperCase(value) ||
        !AppRegex.hasLowerCase(value) ||
        !AppRegex.hasNumber(value)) {
      return 'كلمة المرور يجب أن تحتوي على حروف كبيرة وصغيرة وأرقام';
    }
    return null;
  }

  // التحقق من تأكيد كلمة المرور
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'من فضلك أكد كلمة المرور';
    }
    if (value != password) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }

  // التحقق من رقم الهاتف
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك أدخل رقم الهاتف';
    }
    if (!AppRegex.isPhoneNumberValid(value)) {
      return 'من فضلك أدخل رقم هاتف صحيح';
    }
    return null;
  }

  // التحقق من اسم المستخدم
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك أدخل اسم المستخدم';
    }
    if (!AppRegex.isUsernameValid(value)) {
      return 'اسم المستخدم يجب أن يكون من 3-20 حرف (حروف وأرقام فقط)';
    }
    return null;
  }

  // التحقق من الحقول الفارغة
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'من فضلك أدخل $fieldName';
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
      return 'من فضلك أدخل $fieldName';
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
      return 'من فضلك أدخل $fieldName';
    }
    if (value.length > maxLength) {
      return '$fieldName يجب ألا يتجاوز $maxLength حرف';
    }
    return null;
  }
}
