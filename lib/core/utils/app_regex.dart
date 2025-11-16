class AppRegex {
  // Email validation regex
  static bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Password validation - contains uppercase letter
  static bool hasUpperCase(String password) {
    return RegExp(r'[A-Z]').hasMatch(password);
  }

  // Password validation - contains lowercase letter
  static bool hasLowerCase(String password) {
    return RegExp(r'[a-z]').hasMatch(password);
  }

  // Password validation - contains number
  static bool hasNumber(String password) {
    return RegExp(r'[0-9]').hasMatch(password);
  }

  // Password validation - contains special character
  static bool hasSpecialCharacter(String password) {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  // Phone number validation (Egyptian format)
  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(phoneNumber);
  }

  // Username validation (alphanumeric and underscore only)
  static bool isUsernameValid(String username) {
    return RegExp(r'^[a-zA-Z0-9_]{3,20}$').hasMatch(username);
  }
}
