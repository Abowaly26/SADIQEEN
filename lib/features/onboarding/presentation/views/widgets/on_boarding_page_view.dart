import 'package:flutter/material.dart';
import 'package:sadiqeen/features/onboarding/presentation/views/widgets/page_veiw_item.dart';

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
              'نقدم لك أفضل الفواكه المختارة بعناية. اطلع على التفاصيل والصور والتقييمات لتتأكد من اختيار الفاكهة المثالية',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF4E5456),
                fontSize: 13,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                height: 1.70,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                top: 50,
                child: Text(
                  'ابحث وتسوق',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF0C0D0D) /* Grayscale-950 */,
                    fontSize: 23,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
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
              'كل الحرف بين يديك',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF4E5556) /* Grayscale-500 */,
                fontSize: 13,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                height: 1.70,
              ),
            ),
            
          ),
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: ' مرحبًا بك في',
                  style: TextStyle(
                    color: const Color(0xFF0C0D0D),
                    fontSize: 23,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                TextSpan(
                  text: ' SADIQEEN',
                  style: TextStyle(
                    color: const Color(0xFFF4A91F),
                    fontSize: 23,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
