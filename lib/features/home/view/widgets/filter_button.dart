import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sadiqeen/core/theming/styles.dart';

import 'package:flutter_svg/flutter_svg.dart';

class FilterButton extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  bool get isSvg => icon.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 255, 212, 111)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSvg
                ? SvgPicture.network(
                    icon,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                    placeholderBuilder: (_) =>
                        const SizedBox(width: 20, height: 20),
                  )
                : Image.network(
                    icon,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.error, size: 20, color: Colors.red),
                  ),

            const SizedBox(width: 6),
            Flexible(
              child: Text(
                title,
                style: isSelected
                    ? TextStyles.font12BlackBold
                    : TextStyles.font12Gray700SemiBold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
