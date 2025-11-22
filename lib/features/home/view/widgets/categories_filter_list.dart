import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/features/home/data/models/categories_response_model.dart';
import 'package:sadiqeen/features/home/logic/categories_cubit/categories_cubit.dart';
import 'package:sadiqeen/features/home/logic/categories_cubit/categories_state.dart';
import 'package:sadiqeen/features/home/logic/sub_categories_cubit/sub_categories_cubit.dart';
import 'package:sadiqeen/features/home/view/widgets/filter_button.dart';

class CategoriesFilterList extends StatelessWidget {
  final int? selectedCategoryId;
  final Function(int categoryId) onCategorySelected;
  final VoidCallback onFirstCategoryAutoSelected;

  const CategoriesFilterList({
    super.key,
    required this.selectedCategoryId,
    
    required this.onCategorySelected,
    required this.onFirstCategoryAutoSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        List<Category> categories = [];

        state.maybeWhen(
          success: (data) {
            categories = data;
            // Auto-select first category on first load
            onFirstCategoryAutoSelected();
          },
          orElse: () {},
        );

        if (categories.isEmpty) {
          return const SizedBox(
            height: 50,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(categories.length, (index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterButton(
                    title: category.name,
                    icon: category.icon,
                    isSelected: selectedCategoryId == category.id,
                    onTap: () {
                      onCategorySelected(category.id);
                      context.read<SubCategoriesCubit>().fetchSubCategories(
                        category.id,
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
