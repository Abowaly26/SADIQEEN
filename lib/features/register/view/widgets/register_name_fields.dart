import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sadiqeen/core/utils/app_spacing.dart';
import 'package:sadiqeen/core/utils/app_validation.dart';
import 'package:sadiqeen/core/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterNameFields extends StatelessWidget {
  const RegisterNameFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: CustomTextField(
              hint: 'first_name'.tr(),
              textInputType: TextInputType.name,
              validator: AppValidation.validateUserName,
              controller: firstNameController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-Z\u0600-\u06FF ]'),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8),
            child: CustomTextField(
              hint: 'last_name'.tr(),
              textInputType: TextInputType.name,
              controller: lastNameController,
              validator: AppValidation.validateUserName,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-Z\u0600-\u06FF ]'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
