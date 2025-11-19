import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sadiqeen/core/di/dependency_injection.dart';
import 'package:sadiqeen/core/routing/app_router.dart';
import 'package:sadiqeen/core/routing/routes.dart';
import 'package:sadiqeen/core/theming/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupGetit();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),

      child: SADIQEEN(router: AppRouter()),
    ),
  );
}

class SADIQEEN extends StatelessWidget {
  const SADIQEEN({super.key, required this.router});
  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      onGenerateRoute: router.generateRoute,
      initialRoute: Routes.onboardingScreen,
    );
  }
}
