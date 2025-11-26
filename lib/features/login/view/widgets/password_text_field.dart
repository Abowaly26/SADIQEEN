import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.passwordController,
    required this.obscurePassword,
    required this.onPressed,
  });
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onPressed;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    // 📐 تحديد محاذاة النص حسب اللغة الحالية
    final isArabic = context.locale.languageCode == 'ar';

    return TextFormField(
      controller: widget.passwordController,
      obscureText: widget.obscurePassword,
      // 🔄 محاذاة النص: يمين للعربي، يسار للإنجليزي
      textAlign: isArabic ? TextAlign.right : TextAlign.left,
      decoration: InputDecoration(
        labelText: 'password'.tr(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1A237E), width: 2),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            widget.obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: widget.onPressed,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please_enter_password'.tr();
        }
        return null;
      },
    );
  }
}
