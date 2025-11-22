import 'package:flutter/material.dart';
import 'package:sadiqeen/core/theming/styles.dart';
import 'package:easy_localization/easy_localization.dart';

class EmptyStateWidget extends StatelessWidget {
  final bool isSearching;

  const EmptyStateWidget({super.key, required this.isSearching});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            isSearching ? 'no_search_results'.tr() : 'no_services'.tr(),
            style: TextStyles.font16GrayRegular,
          ),
        ],
      ),
    );
  }
}
