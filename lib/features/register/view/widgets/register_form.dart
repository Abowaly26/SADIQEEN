import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/features/register/logic/register_state.dart';
import 'package:sadiqeen/features/register/view/widgets/register_name_fields.dart';
import 'package:sadiqeen/features/register/view/widgets/register_password_fields.dart';
import 'package:sadiqeen/features/register/view/widgets/register_phone_field.dart';

import '../../../../core/utils/app_spacing.dart';
import '../../../../core/utils/app_validation.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../data/models/register_request_model.dart';
import '../../logic/register_cubit.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String selectedDialCode = '+966';

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RegisterNameFields(
            firstNameController: firstNameController,
            lastNameController: lastNameController,
          ),
          AppSpacing.height20,
          RegisterPhoneField(
            validator: (value) {
              return AppValidation.validatePhoneNumber(value?.number);
            },
            phoneController: phoneController,
            onCountryChanged: (country) {
              setState(() {
                selectedDialCode = country.dialCode;
              });
            },
            onChanged: (phone) {
              phoneController.text = phone.number;
            },
          ),
          AppSpacing.height20,
          RegisterPasswordFields(
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
          ),
          AppSpacing.height40,
          BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (data) {
                  showCustomSnackBar(
                    context: context,
                    message: data.message,
                    backgroundColor: Colors.green,
                    icon: Icons.check_circle,
                  );
                },
                error: (error) {
                  showCustomSnackBar(
                    context: context,
                    message: error,
                    backgroundColor: Colors.red,
                    icon: Icons.error,
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
                isLoading: isLoading,
                onPressed: isLoading ? null : _onSubmit,
                text: 'إنشاء حساب جديد',
              );
            },
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      final request = RegisterRequestModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        countryCode: selectedDialCode,
        phone: phoneController.text,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );

      context.read<RegisterCubit>().registerUser(request);
    }
  }
}
