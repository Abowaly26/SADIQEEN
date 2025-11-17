import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sadiqeen/core/routing/routes.dart';
import 'package:sadiqeen/features/login/logic/cubit/cubit/login_cubit.dart';
import 'package:sadiqeen/core/widgets/custom_new_account.dart.dart';
import 'package:sadiqeen/features/login/view/widgets/intl_phone_field.dart';
import 'package:sadiqeen/features/login/view/widgets/password_text_field.dart';

import '../../../../core/theming/app_colors.dart';
import '../../data/models/login_request_body.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key, required this.isLoading});

  final bool isLoading;

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 65, 65, 65),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "مرحباً بعودتك",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 167, 164, 164),
                    ),
                  ),
                  const SizedBox(height: 40),

                  PhoneField(
                    phoneController: _phoneController,
                    onCountryChanged: (country) {
                      setState(() {
                        _selectedCountryCode = country.code;
                        _selectedDialCode = country.dialCode;
                      });
                    },
                    onChanged: (phone) {
                      _phoneController.text = phone.number;
                      setState(() {
                        _selectedDialCode = phone.countryCode;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  PasswordTextField(
                    passwordController: _passwordController,
                    obscurePassword: _obscurePassword,
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "نسيت كلمة المرور ؟",
                        style: TextStyle(color: Color(0xFF1A237E)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: widget.isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                final loginBody = LoginRequestBody(
                                  countryCode: _selectedDialCode,
                                  phone: _phoneController.text,
                                  password: _passwordController.text,
                                );
                                context.read<LoginCubit>().emitLoginState(
                                  loginBody,
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A237E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: widget.isLoading
                          ? const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            )
                          : Text(
                              "سجل الدخول",
                              style: TextStyle(
                                color: ColorsManager.yellow,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CreateNewAccount(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.registerScreen);
                      },
                      topText: "ليس لديك حساب؟",
                      buttonText: "إنشاء حساب",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
