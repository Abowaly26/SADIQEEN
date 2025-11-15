import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/core/di/dependency_injection.dart';
import 'package:sadiqeen/core/routing/routes.dart';
import 'package:sadiqeen/features/home/logic/categories_cubit/categories_cubit.dart';
import 'package:sadiqeen/features/home/logic/sub_categories_cubit/sub_categories_cubit.dart';
import 'package:sadiqeen/features/home/view/home_view.dart';

import '../../features/login/logic/cubit/cubit/login_cubit.dart';
import '../../features/login/view/login_view.dart';

class AppRouter {
  Route generateRoute(RouteSettings setteing) {
    switch (setteing.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt<LoginCubit>(), //LoginCubit(LoginRepo(ApiService(Dio())))
            child: LoginView(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<SubCategoriesCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<CategoriesCubit>(),
            ),
          ],
          child: HomeView(),
        ));

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('No route defined for ${setteing.name}')),
          ),
        );
    }
  }
}
