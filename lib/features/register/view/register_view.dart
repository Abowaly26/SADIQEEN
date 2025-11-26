import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import '../../../core/utils/app_spacing.dart';
import 'widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    // 📐 تحديد اتجاه النص حسب اللغة الحالية
    final isArabic = context.locale.languageCode == 'ar';

    return Directionality(
      // 🔄 تطبيق RTL للعربي و LTR للإنجليزي على كل الصفحة
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.padding24),
              child: RegisterViewBody(),
            ),
          ),
        ),
      ),
    );
  }
}
