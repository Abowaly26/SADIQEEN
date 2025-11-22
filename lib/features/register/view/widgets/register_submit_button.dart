import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../logic/register_cubit.dart';
import '../../logic/register_state.dart';

class RegisterSubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const RegisterSubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
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
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return CustomButton(
          isLoading: isLoading,
          onPressed: isLoading ? null : onPressed,
          text: 'إنشئ حساب جديد',
        );
      },
    );
  }
}
