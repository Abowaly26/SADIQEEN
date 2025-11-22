import 'package:flutter/material.dart';
import 'package:sadiqeen/core/widgets/custom_new_account.dart.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterLoginRedirect extends StatelessWidget {
  const RegisterLoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CreateNewAccount(
        topText: "no_account".tr(),
        buttomText: "login_title".tr(),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
