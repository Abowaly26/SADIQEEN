import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sadiqeen/core/theming/app_colors.dart';

class PageVeiwItem extends StatelessWidget {
  const PageVeiwItem({
    super.key,
    required this.backgroundImage,
    required this.subtitle,
    required this.title,
    required this.isVisible,
  });
  final String backgroundImage;
  final Widget subtitle;
  final Widget title;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(backgroundImage, fit: BoxFit.fill),
              ),

              GestureDetector(
                onTap: () {},
                child: Visibility(
                  visible: isVisible,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'تخط',
                      style: TextStyle(
                        color: ColorsManager.secondaryBlue,
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 64),
        title,
        SizedBox(height: 37),
        subtitle,
      ],
    );
  }
}
