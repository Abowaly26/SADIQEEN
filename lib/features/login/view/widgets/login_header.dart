import 'package:flutter/material.dart';
import 'package:sadiqeen/core/theming/styles.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('login_title'.tr(), style: TextStyles.font32DarkGrayBold),
        const SizedBox(height: 8),
        Text('welcome_back'.tr(), style: TextStyles.font16GrayRegular),
      ],
    );
  }
}
