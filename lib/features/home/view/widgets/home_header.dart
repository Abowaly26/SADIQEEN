import 'package:flutter/material.dart';
import 'package:sadiqeen/core/theming/styles.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text('services'.tr(), style: TextStyles.font20BlackBold),
      ),
    );
  }
}
