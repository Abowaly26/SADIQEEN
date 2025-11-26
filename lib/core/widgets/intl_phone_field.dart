import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:easy_localization/easy_localization.dart';

import '../theming/styles.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.phoneController,
    required this.onCountryChanged,
    required this.onChanged,
    this.inputFormatters,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.errorText,
  });
  final TextEditingController phoneController;
  final Function(Country)? onCountryChanged;
  final Function(PhoneNumber)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final AutovalidateMode autovalidateMode;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    // 📐 تحديد محاذاة النص حسب اللغة الحالية
    final isArabic = context.locale.languageCode == 'ar';

    return IntlPhoneField(
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      controller: phoneController,
      validator: validator,
      initialCountryCode: 'SA',
      dropdownIcon: const Icon(Icons.keyboard_arrow_down),
      style: TextStyles.font16WhiteMedium.copyWith(color: Colors.black),
      flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 8),
      // 🔄 محاذاة النص: يمين للعربي، يسار للإنجليزي
      textAlign: isArabic ? TextAlign.right : TextAlign.left,
      inputFormatters: inputFormatters,
      onCountryChanged: onCountryChanged,
      decoration: InputDecoration(
        hintText: 'phone_number'.tr(),
        hintStyle: TextStyles.font14LightGrayRegular,
        errorText: errorText,

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
