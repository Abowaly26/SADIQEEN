import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // Private constructor
  SharedPrefHelper._();

  static late SharedPreferences _prefs;

  /// Initialize SharedPreferences (Call this in main)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Keys
  static const String _onboardingKey = 'isOnboardingCompleted';
  static const String _languageKey = 'appLanguage';

  /// Checks if the user has completed onboarding
  static bool isOnboardingCompleted() {
    return _prefs.getBool(_onboardingKey) ?? false;
  }

  /// Marks onboarding as completed
  static Future<void> setOnboardingCompleted() async {
    await _prefs.setBool(_onboardingKey, true);
  }

  /// Clears onboarding status
  static Future<void> clearOnboardingStatus() async {
    await _prefs.remove(_onboardingKey);
  }

  /// حفظ اللغة
  static Future<void> saveLanguage(String langCode) async {
    await _prefs.setString(_languageKey, langCode);
  }

  /// جلب اللغة المحفوظة
  static String? getSavedLanguage() {
    return _prefs.getString(_languageKey);
  }
}
