import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/core/routing/routes.dart';
import 'package:sadiqeen/core/widgets/custom_snack_bar.dart';
import 'package:sadiqeen/features/login/logic/cubit/cubit/login_cubit.dart';
import 'package:sadiqeen/features/login/logic/cubit/cubit/login_state.dart';
import 'package:sadiqeen/features/login/view/widgets/login_view_body.dart';

class LoginViewBlocListener extends StatelessWidget {
  const LoginViewBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (success) {
            showCustomSnackBar(context: context, message: success.message);
            Navigator.pushReplacementNamed(context, Routes.homeScreen);
          },
          error: (error) {
            showCustomSnackBar(
              backgroundColor: Colors.red,
              icon: Icons.error,
              context: context,
              message: error,
            );
          },
        );
      },
      child: LoginViewBody(isLoading: false),
    );
  }
}
