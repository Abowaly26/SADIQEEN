import 'package:flutter/material.dart';

import 'package:sadiqeen/core/utils/app_spacing.dart';

import 'package:sadiqeen/features/register/view/widgets/register_form.dart';
import 'package:sadiqeen/features/register/view/widgets/register_header.dart';
import 'package:sadiqeen/features/register/view/widgets/register_login_redirect.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacing.height40,
        const RegisterHeader(),
        AppSpacing.height20,
        RegisterForm(),
        AppSpacing.height32,
        const RegisterLoginRedirect(),
      ],
    );
  }
}
