import 'package:sadiqeen/features/home/data/models/categories_response_model.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

class CategoriesRepository {
  final ApiService _apiService;
  CategoriesRepository(this._apiService);

  Future<ApiResult<List<Category>>> getCategories() async {
    try {
      final response = await _apiService.getCategories();
      return ApiResult.success(response.data);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
