import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/core/networking/api_result.dart';
import 'categories_state.dart';

import '../../data/repo/categories_repo.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepository _repository;

  CategoriesCubit(this._repository) : super(const CategoriesState.initial());

  Future<void> fetchCategories() async {
    emit(const CategoriesState.loading());

    final result = await _repository.getCategories();

    result.when(
      success: (categories) => emit(CategoriesState.success(categories)),
      failure: (error) =>
          emit(CategoriesState.failure(error.apiErrorModel.message)),
    );
  }
}
