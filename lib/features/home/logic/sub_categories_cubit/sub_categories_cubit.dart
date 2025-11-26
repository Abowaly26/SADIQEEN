import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/core/networking/api_result.dart';
import 'package:sadiqeen/features/home/logic/sub_categories_cubit/sub_categories_state.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../data/repo/sub_categories_repository.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  final SubCategoriesRepository _repository;

  SubCategoriesCubit(this._repository)
    : super(const SubCategoriesState.initial());

  Future<void> fetchSubCategories(int categoryId, {String? search}) async {
    if (isClosed) return;
    try {
      emit(const SubCategoriesState.loading());

      final result = await _repository.getSubCategories(
        categoryId: categoryId,
        search: search,
      );

      if (isClosed) return;
      result.when(
        success: (subCategories) {
          if (subCategories != null && subCategories.data != null) {
            emit(SubCategoriesState.success(subCategories));
          }
        },
        failure: (error) {
          final errorMessage =
              error.apiErrorModel.message ?? 'error_unexpected'.tr();
          debugPrint('SubCategories Error: $errorMessage');
          if (!isClosed) emit(SubCategoriesState.error(errorMessage));
        },
      );
    } catch (e) {
      debugPrint('Unexpected error in fetchSubCategories: $e');
      if (!isClosed) emit(SubCategoriesState.error('error_loading_data'.tr()));
    }
  }
}
