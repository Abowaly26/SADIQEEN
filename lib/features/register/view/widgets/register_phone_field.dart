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
  final String? Function(PhoneNumber?)? validator;

  const RegisterPhoneField({
    super.key,
    required this.phoneController,
    required this.onCountryChanged,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) {
        // Use the controller text for validation as it contains the number
        return validator?.call(
          PhoneNumber(
            countryISOCode: 'SA',
            countryCode: '+966',
            number: phoneController.text,
          ),
        );
      },
      builder: (state) {
        return PhoneField(
          onCountryChanged: onCountryChanged,
          onChanged: (phone) {
            // Update FormField state when phone changes
            state.didChange(phone.number);
            onChanged(phone);
          },
          phoneController: phoneController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          // Pass the error text from FormField state to PhoneField
          errorText: state.errorText,
        );
      },
    );
  }
}
