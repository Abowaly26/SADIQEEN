import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/core/di/dependency_injection.dart';
import 'package:sadiqeen/core/routing/routes.dart';
import 'package:sadiqeen/features/home/logic/categories_cubit/categories_cubit.dart';
import 'package:sadiqeen/features/home/logic/sub_categories_cubit/sub_categories_cubit.dart';
import 'package:sadiqeen/features/home/view/home_view.dart';
import 'package:sadiqeen/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:sadiqeen/features/register/logic/register_cubit.dart';
import 'package:sadiqeen/features/register/view/register_view.dart';

import '../../features/home/view/setting.dart';
import '../../features/login/logic/cubit/cubit/login_cubit.dart';
import '../../features/login/view/login_view.dart';

class AppRouter {
  Route generateRoute(RouteSettings setteing) {
    switch (setteing.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<LoginCubit>(),
            child: LoginView(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<CategoriesCubit>(),
            child: BlocProvider.value(
              value: getIt<SubCategoriesCubit>(),
              child: HomeView(),
            ),
          ),
        );

      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<RegisterCubit>(),
            child: RegisterView(),
          ),
        );

      case Routes.settingScreen:
        return MaterialPageRoute(builder: (context) => SettingView());

      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (context) => OnboardingView());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('No route defined for ${setteing.name}')),
          ),
        );
    }
  }
}
