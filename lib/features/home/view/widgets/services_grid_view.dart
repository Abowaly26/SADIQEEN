import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/core/theming/styles.dart';
import 'package:sadiqeen/features/home/logic/sub_categories_cubit/sub_categories_cubit.dart';
import 'package:sadiqeen/features/home/logic/sub_categories_cubit/sub_categories_state.dart';
import 'package:sadiqeen/features/home/view/widgets/empty_state_widget.dart';
import 'package:sadiqeen/features/home/view/widgets/error_state_widget.dart';
import 'package:sadiqeen/features/home/view/widgets/service_card.dart';
import 'package:easy_localization/easy_localization.dart';

class ServicesGridView extends StatelessWidget {
  final bool isSearching;
  final int? selectedCategoryId;

  const ServicesGridView({
    super.key,
    required this.isSearching,
    required this.selectedCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(
              child: Text(
                'select_category'.tr(),
                style: TextStyles.font16GrayRegular,
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (services) {
              final servicesList = services.data;

              if (servicesList.isEmpty) {
                return EmptyStateWidget(isSearching: isSearching);
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: servicesList.length,
                itemBuilder: (context, index) {
                  final service = servicesList[index];

                  if (service.id == null || service.name == null) {
                    return const SizedBox.shrink();
                  }

                  return ServiceCard(
                    image: service.icon ?? "",
                    title: service.name!,
                    color: Colors.blue,
                  );
                },
              );
            },
            error: (message) => ErrorStateWidget(
              errorMessage: message,
              onRetry: () {
                if (selectedCategoryId != null) {
                  context.read<SubCategoriesCubit>().fetchSubCategories(
                    selectedCategoryId!,
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
