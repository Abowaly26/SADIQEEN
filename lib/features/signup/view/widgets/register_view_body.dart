import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/features/signup/data/models/register_request_model.dart';
import 'package:sadiqeen/features/signup/logic/register_cubit.dart';
import 'package:sadiqeen/features/signup/logic/register_state.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_password_text_field.dart';
import '../../../../core/utils/app_validation.dart';
import '../../../login/view/widgets/intl_phone_field.dart';
import '../../../../core/widgets/custom_snack_bar.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
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

  void handleSignUp() {
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (data) {
            showCustomSnackBar(
              context: context,
              message: data.message,
              backgroundColor: Colors.green,
              icon: Icons.check_circle,
              duration: const Duration(seconds: 3),
            );
          },
          error: (error) {
            showCustomSnackBar(
              context: context,
              message: error,
              backgroundColor: Colors.red,
              icon: Icons.error,
              duration: const Duration(seconds: 3),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // First & Last Name Fields
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: firstNameController,
                            validator: AppValidation.validateUserName,
                            hint: 'الاسم الأول',
                            textInputType: TextInputType.name,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomTextField(
                            controller: lastNameController,
                            validator: AppValidation.validateUserName,
                            hint: 'الاسم الأخير',
                            textInputType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Phone Field
                    PhoneField(
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
                    const SizedBox(height: 20),
                    // Password Fields
                    CustomPasswordTextField(
                      controller: passwordController,
                      obscurePassword: obscurePassword,
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      labelText: 'كلمة المرور',
                      validator: AppValidation.validatePassword,
                    ),
                    const SizedBox(height: 20),
                    CustomPasswordTextField(
                      controller: confirmPasswordController,
                      obscurePassword: obscureConfirmPassword,
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                        });
                      },
                      labelText: 'تأكيد كلمة المرور',
                      validator: (value) {
                        return AppValidation.validateConfirmPassword(
                            value, passwordController.text);
                      },
                    ),
                    const SizedBox(height: 30),
                    // Submit Button
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                            loading: () => true, orElse: () => false);
                        return SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : handleSignUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A237E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "انشئ حساب جديد",
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    // Login redirect
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const Text(
                            "لديك حساب بالفعل؟",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                color: Color(0xFF1A237E),
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
