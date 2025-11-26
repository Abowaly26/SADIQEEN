import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/features/home/logic/categories_cubit/categories_cubit.dart';
import 'package:sadiqeen/features/home/logic/categories_cubit/categories_state.dart';
import 'package:sadiqeen/features/home/logic/sub_categories_cubit/sub_categories_cubit.dart';

import 'package:sadiqeen/features/home/view/widgets/categories_filter_list.dart';
import 'package:sadiqeen/features/home/view/widgets/home_header.dart';
import 'package:sadiqeen/features/home/view/widgets/home_search_bar.dart';
import 'package:sadiqeen/features/home/view/widgets/services_grid_view.dart';

import '../../../../core/utils/app_spacing.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int? _selectedCategoryId;
  final TextEditingController _searchController = TextEditingController();
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().fetchCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpacing.height24,
        const HomeHeader(),
        AppSpacing.height16,
        HomeSearchBar(
          searchController: _searchController,
          selectedCategoryId: _selectedCategoryId,
          onSeachChanged: _handleSearchChanged,
        ),
        AppSpacing.height16,
        CategoriesFilterList(
          selectedCategoryId: _selectedCategoryId,
          onCategorySelected: _handleCategorySelection,
          onFirstCategoryAutoSelected: _handleFirstCategoryAutoSelection,
        ),
        Expanded(
          child: ServicesGridView(
            isSearching: _searchController.text.isNotEmpty,
            selectedCategoryId: _selectedCategoryId,
            onRetry: () {
              _searchController.clear();
              if (_selectedCategoryId != null) {
                context.read<SubCategoriesCubit>().fetchSubCategories(
                  _selectedCategoryId!,
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void _handleFirstCategoryAutoSelection() {
    if (_isFirstLoad) {
      final categoriesState = context.read<CategoriesCubit>().state;

      categoriesState.maybeWhen(
        success: (categories) {
          if (categories.isNotEmpty) {
            _isFirstLoad = false;
            final firstCategory = categories[0];
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _selectedCategoryId = firstCategory.id;
                });
                context.read<SubCategoriesCubit>().fetchSubCategories(
                  firstCategory.id,
                );
              }
            });
          }
        },
        orElse: () {},
      );
    }
  }

  void _handleCategorySelection(int categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
      _searchController.clear();
    });
  }

  void _handleSearchChanged(String searchQuery) {
    if (_selectedCategoryId != null) {
      try {
        context.read<SubCategoriesCubit>().fetchSubCategories(
          _selectedCategoryId!,
          search: searchQuery.trim().isEmpty ? null : searchQuery.trim(),
        );
      } catch (e) {
        debugPrint('Search error: $e');
      }
    }
  }
}
