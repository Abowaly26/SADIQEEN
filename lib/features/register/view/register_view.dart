import 'package:flutter/material.dart';

import '../../../core/utils/app_spacing.dart';
import 'widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.padding24),
            child: RegisterViewBody(),
          ),
        ),
      ),
    );
  }
}
