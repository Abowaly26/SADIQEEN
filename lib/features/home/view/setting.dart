import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';

import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/networking/dio_factory.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  late bool isEnglish;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 🔄 تهيئة حالة الـ Switch حسب اللغة الحالية
    isEnglish = context.locale.languageCode == 'en';
  }

  /// 🌐 دالة تغيير اللغة - تنفذ عند الضغط على الـ Switch
  void _onLanguageChanged(bool value) async {
    final newLanguage = value ? 'en' : 'ar';

    // 1️⃣ تغيير لغة التطبيق فوراً (UI)
    await context.setLocale(Locale(newLanguage));

    // 2️⃣ تحديث language header في API requests
    DioFactory.updateLanguage(newLanguage);

    // 3️⃣ حفظ اللغة المختارة في SharedPreferences
    await SharedPrefHelper.saveLanguage(newLanguage);

    // 4️⃣ تحديث حالة الـ UI (Switch)
    if (mounted) {
      setState(() {
        isEnglish = value;
      });
    }

    // ✅ MaterialApp سيعيد بناء نفسه تلقائياً بسبب ValueKey في main.dart
    // كل الصفحات والنصوص ستتحدث فوراً بدون الحاجة لـ hot reload
  }

  @override
  Widget build(BuildContext context) {
    // 📐 تحديد اتجاه النص حسب اللغة الحالية
    final isArabic = context.locale.languageCode == 'ar';

    return Directionality(
      // 🔄 تطبيق RTL للعربي و LTR للإنجليزي
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SwitchListTile(
              title: Text('language'.tr()),
              subtitle: Text('switch_language'.tr()),
              secondary: const Icon(Icons.language),
              value: isEnglish,
              onChanged: _onLanguageChanged,
            ),
          ),
        ),
      ),
    );
  }
}
