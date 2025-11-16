import 'package:flutter/material.dart';

import '../../../../core/routing/routes.dart';

class CreateNewAccount extends StatelessWidget {
  const CreateNewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "ليس لديك حساب ؟",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.signupScreen);
          },
          child: const Text(
            "انشئ حساب جديد",
            style: TextStyle(
              color: Color(0xFF1A237E),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
