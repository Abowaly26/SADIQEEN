import 'package:flutter/material.dart';
import 'package:sadiqeen/core/helpers/extensions.dart';
import 'package:sadiqeen/core/routing/routes.dart';
import 'package:sadiqeen/core/theming/styles.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('services'.tr(), style: TextStyles.font20BlackBold),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.pushNamed(Routes.settingScreen);
            },
          ),
        ],
      ),
    );
  }
}
