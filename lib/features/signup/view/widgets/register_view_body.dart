import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/core/routing/routes.dart';
import 'package:sadiqeen/features/signup/data/models/register_request_model.dart';
import 'package:sadiqeen/features/signup/logic/register_cubit.dart';
import 'package:sadiqeen/features/signup/logic/register_state.dart';
import 'package:sadiqeen/features/signup/view/widgets/register_bloc_listener.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_new_account.dart.dart';
import '../../../../core/widgets/custom_text_field.dart';
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
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: RegisterBlocListner(
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
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z\u0600-\u06FF ]'),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomTextField(
                            controller: lastNameController,
                            validator: AppValidation.validateUserName,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z\u0600-\u06FF ]'),
                              ),
                            ],
                            hint: 'الاسم الأخير',
                            textInputType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Phone Field
                    PhoneField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      phoneController: phoneController,
                      validator: (value) {
                        return AppValidation.validatePhoneNumber(value!.number);
                      },
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
                    CustomTextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                          RegExp(r'[\u0600-\u06FF]'),
                        ),
                      ],
                      controller: passwordController,
                      obscureText: obscurePassword,
                      // inputFormatters:
                      validator: AppValidation.validatePassword,
                      hint: 'كلمة المرور',
                      textInputType: TextInputType.visiblePassword,

                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                          RegExp(r'[\u0600-\u06FF]'),
                        ),
                      ],
                      textInputType: TextInputType.visiblePassword,
                      // inputFormatters:
                      controller: confirmPasswordController,
                      obscureText: obscureConfirmPassword,
                      hint: 'تأكيد كلمة المرور',

                      validator: (value) {
                        return AppValidation.validateConfirmPassword(
                          value,
                          passwordController.text,
                        );
                      },

                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureConfirmPassword = !obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Submit Button
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );
                        return CustomButton(
                          isLoading: isLoading,
                          onPressed: handleSignUp,
                          text: 'انشئ حساب جديد',
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    // Login redirect
                    Align(
                      alignment: Alignment.center,

                      child: CreateNewAccount(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        topText: "لديك حساب بالفعل؟",
                        buttonText: "تسجيل الدخول",
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
