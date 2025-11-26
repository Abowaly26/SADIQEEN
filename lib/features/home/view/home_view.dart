import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:sadiqeen/features/home/view/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // 📐 تحديد اتجاه النص حسب اللغة الحالية
    final isArabic = context.locale.languageCode == 'ar';

    return Directionality(
      // 🔄 تطبيق RTL للعربي و LTR للإنجليزي على كل الصفحة
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: const SafeArea(child: HomeViewBody()),
      ),
    );
  }
}
