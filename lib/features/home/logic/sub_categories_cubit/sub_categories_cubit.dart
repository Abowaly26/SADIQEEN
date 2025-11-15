import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/core/networking/api_result.dart';
import 'package:sadiqeen/features/home/logic/sub_categories_cubit/sub_categories_state.dart';
import '../../data/repo/sub_categories_repository.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  final SubCategoriesRepository _repository;

  SubCategoriesCubit(this._repository) : super(const SubCategoriesState.initial());

  Future<void> fetchSubCategories(int categoryId, {String? search}) async {
    try {
      emit(const SubCategoriesState.loading());

      final result = await _repository.getSubCategories(
        categoryId: categoryId,
        search: search,
      );

      result.when(
        success: (subCategories) {
        
          if (subCategories != null && subCategories.data != null) {
            emit(SubCategoriesState.success(subCategories));
          }
        },
        failure: (error) {
          final errorMessage = error.apiErrorModel.message ?? 'حدث خطأ غير متوقع';
          debugPrint('SubCategories Error: $errorMessage');
          emit(SubCategoriesState.error(errorMessage));
        },
      );
    } catch (e) {
      debugPrint('Unexpected error in fetchSubCategories: $e');
      emit(SubCategoriesState.error('حدث خطأ أثناء تحميل البيانات'));
    }
  }
}