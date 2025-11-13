// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AppRouter {
//   Route generateRoute(RouteSettings setteing) {
//     switch (setteing.name) {
//       case Routes.loginScreen:
//         return MaterialPageRoute(
//           builder: (context) => BlocProvider(
//             create: (context) =>
//                 getIt<LoginCubit>(), //LoginCubit(LoginRepo(ApiService(Dio())))
//             child: LoginView(),
//           ),
//         );

//       default:
//         return MaterialPageRoute(
//           builder: (context) => Scaffold(
//             body: Center(child: Text('No route defined for ${setteing.name}')),
//           ),
//         );
//     }
//   }
// }
