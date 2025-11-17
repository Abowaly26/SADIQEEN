import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_snack_bar.dart';
import '../../logic/register_cubit.dart';
import '../../logic/register_state.dart';

class RegisterBlocListner extends StatelessWidget {
  const RegisterBlocListner({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (data) {
            showCustomSnackBar(
              context: context,
              message: data.message,
              backgroundColor: Colors.green,
              icon: Icons.check_circle,
            );
          },
          error: (error) {
            showCustomSnackBar(
              context: context,
              message: error,
              backgroundColor: Colors.red,
              icon: Icons.error,
            );
          },
        );
      },
      child: child,
    );
  }
}
