import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../core/theming/app_colors.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.phoneController,
    required this.onCountryChanged,
    required this.onChanged,
    this.inputFormatters,
    this.validator,
  });
  final TextEditingController phoneController;
  final Function(Country)? onCountryChanged;
  final Function(PhoneNumber)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
 final FutureOr<String?> Function(PhoneNumber?)? validator;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      onChanged: onChanged,
      controller: phoneController,
      validator: validator,
      initialCountryCode: 'SA',
      dropdownIcon: const Icon(Icons.keyboard_arrow_down),
      style: const TextStyle(fontSize: 16),
      flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 8),
      textAlign: TextAlign.right,
      inputFormatters: inputFormatters,
      onCountryChanged: onCountryChanged,
      decoration: InputDecoration(
        hintText: 'رقم الهاتف',
        hintStyle: TextStyle(color: ColorsManager.lightGray),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1A237E), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
      ),
     
      
    );
  }
}
