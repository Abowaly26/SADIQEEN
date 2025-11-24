import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sadiqeen/core/theming/styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.icon,
    required this.hint,
    this.onSaved,
    required this.textInputType,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.inputFormatters,
    this.enableInteractiveSelection = true,
  });

  final String? icon;
  final String hint;
  final TextInputType textInputType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool enableInteractiveSelection;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: enableInteractiveSelection,
      obscureText: obscureText,
      controller: controller,
      keyboardType: textInputType,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,

      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyles.font14LightGrayRegular,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1A237E), width: 2),
        ),
      ),
    );
  }
}
