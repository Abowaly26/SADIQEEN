import 'package:flutter/material.dart';


class CustomPasswordTextField extends StatelessWidget {
  const CustomPasswordTextField({super.key, required this.controller, required this.obscurePassword, required this.onPressed, required this.labelText, required this.validator});

  final TextEditingController controller;
  final bool obscurePassword;
  final void Function()? onPressed;
  final String labelText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscurePassword,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: labelText,
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
            obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: onPressed,
        ),
      ),
      
    );
  }
}
