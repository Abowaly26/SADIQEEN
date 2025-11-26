import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:sadiqeen/core/utils/app_spacing.dart';
import 'package:sadiqeen/features/login/view/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 📐 تحديد اتجاه النص حسب اللغة الحالية
    final isArabic = context.locale.languageCode == 'ar';

    return Directionality(
      // 🔄 تطبيق RTL للعربي و LTR للإنجليزي على كل الصفحة
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.padding24),
            child: LoginViewBody(),
          ),
        ),
      ),
    );
  }
}
