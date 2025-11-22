import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sadiqeen/core/routing/routes.dart';
import 'package:sadiqeen/features/onboarding/presentation/views/widgets/on_boarding_page_view.dart';
import 'package:sadiqeen/core/helpers/shared_pref_helper.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late PageController pageController;
  var currentPage = 0;

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      currentPage = pageController.page!.round();
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: OnBoardingPageView(pageController: pageController)),
        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            color: currentPage == 1
                ? ColorsManager.mainColor
                : ColorsManager.mainColor.withOpacity(0.5),
            activeColor: ColorsManager.mainColor,
          ),
        ),
        SizedBox(height: 16),
        Visibility(
          visible: currentPage == 1 ? true : false,
          maintainAnimation: true,
          maintainSize: true,
          maintainState: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'start_now'.tr(),
              onPressed: () async {
                // Save onboarding completion status
                await SharedPrefHelper.setOnboardingCompleted();
                Navigator.pushReplacementNamed(context, Routes.loginScreen);
              },
            ),
          ),
        ),
      ],
    );
  }
}
