import 'package:flutter/widgets.dart';
import 'package:sadiqeen/core/widgets/custom_new_account.dart.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/routing/routes.dart';

class CustomCreateNewAccount extends StatelessWidget {
  const CustomCreateNewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CreateNewAccount(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.registerScreen);
        },
        topText: 'no_account'.tr(),
        buttomText: 'create_account'.tr(),
      ),
    );
  }
}
