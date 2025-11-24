import 'package:flutter/material.dart';
import 'package:sadiqeen/core/utils/app_spacing.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/theming/styles.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    required this.searchController,
    this.selectedCategoryId,
    required this.onSeachChanged,
  });
  final TextEditingController searchController;
  final int? selectedCategoryId;
  final Function(String) onSeachChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.padding24),
      child: TextField(
        controller: searchController,
        enabled: selectedCategoryId != null,
        onChanged: onSeachChanged,
        decoration: InputDecoration(
          hintStyle: TextStyles.font16Gray400Regular,
          hintText: selectedCategoryId == null
              ? 'search_placeholder_disabled'.tr()
              : 'search_placeholder'.tr(),

          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          filled: true,
          fillColor: selectedCategoryId == null
              ? Colors.grey[200]
              : Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
