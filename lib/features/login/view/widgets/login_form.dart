import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sadiqeen/core/utils/app_spacing.dart';
import 'package:sadiqeen/core/utils/app_validation.dart';
import 'package:sadiqeen/core/widgets/custom_snack_bar.dart';
import 'package:sadiqeen/features/login/view/widgets/password_text_field.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/intl_phone_field.dart';
import '../../data/models/login_request_body.dart';
import '../../logic/cubit/cubit/login_cubit.dart';
import '../../logic/cubit/cubit/login_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  String _selectedCountryCode = 'SA';

  String _selectedDialCode = '+966';

  Function(Country)? onCountryChanged;

  Function(PhoneNumber)? onChanged;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormField<String>(
            validator: (value) {
              return AppValidation.validatePhoneNumber(_phoneController.text);
            },
            builder: (state) {
              return PhoneField(
                phoneController: _phoneController,
                errorText: state.errorText,
                onCountryChanged: (country) {
                  setState(() {
                    _selectedCountryCode = country.code;
                    _selectedDialCode = country.dialCode;
                  });
                },
                onChanged: (phone) {
                  state.didChange(phone.number);
                  _phoneController.text = phone.number;
                  setState(() {
                    _selectedDialCode = phone.countryCode;
                  });
                },
              );
            },
          ),

          AppSpacing.height20,

          PasswordTextField(
            passwordController: _passwordController,
            obscurePassword: _obscurePassword,
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),

          TextButton(
            onPressed: () {},
            child: Text(
              'forgot_password'.tr(),
              style: TextStyles.font12BlackBold,
            ),
          ),

          AppSpacing.height20,

          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (success) {
                  showCustomSnackBar(
                    context: context,
                    message: success.message,
                  );
                  Navigator.pushReplacementNamed(context, Routes.homeScreen);
                },
                error: (error) {
                  showCustomSnackBar(
                    backgroundColor: Colors.red,
                    icon: Icons.error,
                    context: context,
                    message: error,
                  );
                },
              );
            },
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );

              return CustomButton(
                onPressed: isLoading ? null : _onSubmit,
                isLoading: isLoading,
                text: 'login'.tr(),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final loginBody = LoginRequestBody(
        countryCode: _selectedDialCode,
        phone: _phoneController.text,
        password: _passwordController.text,
      );
      context.read<LoginCubit>().emitLoginState(loginBody);
    }
  }
}
