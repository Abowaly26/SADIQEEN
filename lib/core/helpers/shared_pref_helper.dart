import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // Private constructor
  SharedPrefHelper._();

  // Keys
  static const String _onboardingKey = 'isOnboardingCompleted';

  /// Checks if the user has completed onboarding
  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  /// Marks onboarding as completed
  static Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  /// Clears onboarding status (useful for testing)
  static Future<void> clearOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingKey);
  }
}
