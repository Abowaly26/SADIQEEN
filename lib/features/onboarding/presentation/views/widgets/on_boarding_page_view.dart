import 'package:flutter/material.dart';
import 'package:sadiqeen/core/theming/styles.dart';
import 'package:sadiqeen/features/onboarding/presentation/views/widgets/page_veiw_item.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../core/utils/images.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        PageVeiwItem(
          isVisible: true,
          backgroundImage: Assets.vectororange,
          subtitle: SizedBox(
            width: 301,
            child: Text(
              'onboarding_desc_1'.tr(),
              textAlign: TextAlign.center,
              style: TextStyles.font13DarkGraySemiBold,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                top: 50,
                child: Text(
                  'onboarding_title_1'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyles.font23BlackBold,
                ),
              ),
            ],
          ),
        ),
        PageVeiwItem(
          isVisible: false,
          backgroundImage: Assets.vectorgreen,
          subtitle: SizedBox(
            width: 301,
            child: Text(
              'onboarding_desc_2'.tr(),
              textAlign: TextAlign.center,
              style: TextStyles.font13DarkGraySemiBold,
            ),
          ),
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: ' مرحبًا بك في',
                  style: TextStyles.font23BlackBold,
                ),

                TextSpan(text: ' SADIQEEN', style: TextStyles.font23YellowBold),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
