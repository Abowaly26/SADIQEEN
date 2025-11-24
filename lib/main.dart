import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sadiqeen/core/di/dependency_injection.dart';
import 'package:sadiqeen/core/routing/app_router.dart';
import 'package:sadiqeen/core/routing/routes.dart';
import 'package:sadiqeen/core/helpers/shared_pref_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupGetit();

  // Check if onboarding has been completed

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

class SADIQEEN extends StatefulWidget {
  const SADIQEEN({super.key, required this.router});
  final AppRouter router;

  @override
  State<SADIQEEN> createState() => _SADIQEENState();
}

class _SADIQEENState extends State<SADIQEEN> {
  String? _initialRoute;

  @override
  void initState() {
    super.initState();
    _loadInitialRoute();
  }

  Future<void> _loadInitialRoute() async {
    bool onboardingDone = await SharedPrefHelper.isOnboardingCompleted();

    setState(() {
      _initialRoute = onboardingDone
          ? Routes.loginScreen
          : Routes.onboardingScreen;
    });
  }

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
      onGenerateRoute: widget.router.generateRoute,
      initialRoute: Routes.onboardingScreen,
    );
  }
}
