import 'package:flutter/material.dart';
import 'package:sadiqeen/core/utils/app_spacing.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/theming/styles.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('register'.tr(), style: TextStyles.font32DarkGrayBold),
        AppSpacing.height8,

        Text(
          'register_header'.tr(),
          textAlign: TextAlign.center,
          style: TextStyles.font16GrayRegular,
        ),
      ],
    );
  }
}
