import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.phoneController,
    required this.onCountryChanged,
    required this.onChanged,
  });
  final TextEditingController phoneController;
  final Function(Country)? onCountryChanged;
  final Function(PhoneNumber)? onChanged;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: phoneController,
      initialCountryCode: 'SA',
      dropdownIcon: const Icon(Icons.keyboard_arrow_down),
      style: const TextStyle(fontSize: 16),
      flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 8),
      textAlign: TextAlign.right,

      onCountryChanged: onCountryChanged,
      decoration: InputDecoration(
        labelText: 'رقم الهاتف',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.number.isEmpty) {
          return "الرجاء إدخال رقم الهاتف";
        }
        return null;
      },
    );
  }
}
