import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sadiqeen/core/di/dependency_injection.dart';
import 'package:sadiqeen/core/routing/app_router.dart';
import 'package:sadiqeen/core/routing/routes.dart';
import 'package:sadiqeen/core/helpers/shared_pref_helper.dart';
import 'package:sadiqeen/core/networking/dio_factory.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // 🌐 تهيئة SharedPreferences مرة واحدة عند بدء التطبيق
  await SharedPrefHelper.init();
  await setupGetit();

  // 📖 قراءة اللغة المحفوظة من SharedPreferences
  final savedLanguage = SharedPrefHelper.getSavedLanguage();

  // 🔧 تهيئة Dio مع اللغة المحفوظة لإرسالها في API headers
  DioFactory.initializeLanguage(savedLanguage ?? 'ar');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: Locale(savedLanguage ?? 'ar'),
      child: SADIQEEN(router: AppRouter()),
    ),
  );
}

class SADIQEEN extends StatefulWidget {
  const SADIQEEN({super.key, required this.router});
  final AppRouter router;

  @override
  State<SADIQEEN> createState() => _SADIQEENState();
}

class _SADIQEENState extends State<SADIQEEN> {
  @override
  Widget build(BuildContext context) {
    final isOnboardingCompleted = SharedPrefHelper.isOnboardingCompleted();

    return MaterialApp(
      // 🔑 ValueKey مهم جداً: يجبر MaterialApp على إعادة البناء عند تغيير اللغة
      // عندما تتغير اللغة، يتغير languageCode، فيتغير الـ key، فيعيد Flutter بناء كل شيء
      key: ValueKey(context.locale.languageCode),

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      onGenerateRoute: widget.router.generateRoute,
      initialRoute: isOnboardingCompleted
          ? Routes.loginScreen
          : Routes.onboardingScreen,
    );
  }
}
