import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sadiqeen/core/di/dependency_injection.dart';
import 'package:sadiqeen/core/theming/app_colors.dart';
import 'package:sadiqeen/features/login/data/models/login_request_body.dart';
import 'package:sadiqeen/features/login/logic/cubit/cubit/login_cubit.dart';
import 'package:sadiqeen/features/login/logic/cubit/cubit/login_state.dart';
import 'package:sadiqeen/features/login/view/widgets/create_new_account.dart';
import 'package:sadiqeen/features/login/view/widgets/password_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String _selectedCountryCode = 'SA';
  String _selectedDialCode = '+966';

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => getIt<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
              );
            },
            error: (error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(error)));
            },
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

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

                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: IntlPhoneField(
                            controller: _phoneController,
                            initialCountryCode: 'SA',
                            dropdownIcon: const Icon(Icons.keyboard_arrow_down),
                            style: const TextStyle(fontSize: 16),
                            flagsButtonPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),

                            textAlign: TextAlign.right,

                            onCountryChanged: (country) {
                              setState(() {
                                _selectedCountryCode = country.code;
                                _selectedDialCode = country.dialCode;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'رقم الهاتف',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),
                            ),
                            onChanged: (phone) {
                              _phoneController.text = phone.number;
                              setState(() {
                                _selectedDialCode = phone.countryCode;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.number.isEmpty) {
                                return "الرجاء إدخال رقم الهاتف";
                              }
                              return null;
                            },
                          ),
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
                          height: 55,
                          child: ElevatedButton(
                            onPressed: isLoading
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
                            child: isLoading
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
                        CreateNewAccount(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
