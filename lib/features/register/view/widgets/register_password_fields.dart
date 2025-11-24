import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sadiqeen/core/utils/app_spacing.dart';
import 'package:sadiqeen/core/utils/app_validation.dart';
import 'package:sadiqeen/core/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterPasswordFields extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterPasswordFields({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<RegisterPasswordFields> createState() => _RegisterPasswordFieldsState();
}

class _RegisterPasswordFieldsState extends State<RegisterPasswordFields> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'[\u0600-\u06FF]')),
          ],
          controller: widget.passwordController,
          obscureText: obscurePassword,
          validator: AppValidation.validatePassword,
          hint: 'password'.tr(),
          textInputType: TextInputType.visiblePassword,
          enableInteractiveSelection: false,
          suffixIcon: IconButton(
            icon: Icon(
              obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
        ),
        AppSpacing.height20,
        CustomTextField(
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'[\u0600-\u06FF]')),
          ],
          textInputType: TextInputType.visiblePassword,
          controller: widget.confirmPasswordController,
          obscureText: obscureConfirmPassword,
          enableInteractiveSelection: false,
          hint: 'confirm_password'.tr(),
          validator: (value) {
            return AppValidation.validateConfirmPassword(
              value,
              widget.passwordController.text,
            );
          },
          suffixIcon: IconButton(
            icon: Icon(
              obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                obscureConfirmPassword = !obscureConfirmPassword;
              });
            },
          ),
        ),
      ],
    );
  }
}
