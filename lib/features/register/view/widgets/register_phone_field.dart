import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../../core/utils/app_validation.dart';
import '../../../../core/widgets/intl_phone_field.dart';

class RegisterPhoneField extends StatelessWidget {
  final TextEditingController phoneController;
  final void Function(Country) onCountryChanged;
  final void Function(PhoneNumber) onChanged;

  const RegisterPhoneField({
    super.key,
    required this.phoneController,
    required this.onCountryChanged,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PhoneField(
      onCountryChanged: onCountryChanged,
      onChanged: onChanged,
      phoneController: phoneController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],

      validator: (value) {
        return AppValidation.validatePhoneNumber(value!.number);
      },
    );
  }
}
