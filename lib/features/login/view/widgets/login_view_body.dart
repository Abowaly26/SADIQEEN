import 'package:flutter/material.dart';

import 'package:sadiqeen/core/utils/app_spacing.dart';
import 'package:sadiqeen/features/login/view/widgets/login_form.dart';
import 'package:sadiqeen/features/login/view/widgets/login_header.dart';
import 'package:sadiqeen/features/login/view/widgets/new_account_action.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginHeader(),
          AppSpacing.height20,
          LoginForm(),
          AppSpacing.height20,
          CustomCreateNewAccount(),
        ],
      );
  }
}
