import 'package:flutter/material.dart';
import 'package:sadiqeen/core/utils/app_spacing.dart';
import 'package:sadiqeen/features/login/view/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.padding24),
          child: LoginViewBody(isLoading: false),
        ),
      ),
    );
  }
}
